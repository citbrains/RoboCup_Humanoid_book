#!/bin/bash
#データセット用のフォルダ
dataset="dataset"
data="v4tiny_3class.data"
cfg="v4tiny_3class.cfg"
names="v4tiny_3class.names"
dir="syoseki"

case_train="train"
case_test="test"
path_weights="backup/syoseki/v4tiny_3class_best.weights"
echo ${path_weights}
if [ $# -eq 1 ]; then
	arg=$1
else 
	echo "Usage: !bash $0 <train/test>"
	exit
fi
	

if [ $arg == $case_train ];then
#データセットがあるか確認
	if [ ! -e $dataset ];then
		echo "データセットを同一階層においてください"
		exit
	fi

	#google coraboratoryでGPUをマウントしているか確認
	#if ! command -v nvidia-smi &> /dev/null
	flag="true"
	command nvidia-smi &> /dev/null || flag="false";

	if [ $flag == "false" ];then
		echo "GPUをマウントしてください"
		exit 1;
	fi


	echo "cloning darknet"
	git clone -b dev https://github.com/RikuYokoo/darknet.git
	echo "finish cloning darknet"

	sleep 1

	cd darknet

	echo "$PWD"
	sleep 2

	#train.txtの作成(datasetまでのパスファイル) 
	readlink -f ../${dataset}/*txt > train.txt
	sed -i "s/txt/jpg/" train.txt

	#dataファイルの作成
	#train.txtまでのパスを記入
	path_train=`readlink -f train.txt`
	sed -i "s:train =:train = ${path_train}:" ${dir}/${data}

	#重みを保存するディレクトリの作成
	if [ ! -e "backup/syoseki" ]; then
		mkdir -p backup/syoseki
	fi
	#初期重みのダウンロード
	echo "download weights"
	sleep 1
	wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v4_pre/yolov4-tiny.conv.29
	echo "end download weights"

	#darknetのmake
	echo "make darknet"
	sleep 1
	make -j2
	echo "end make darknet"

	sleep 3

	echo "start training"
	sleep 1
	./darknet detector train syoseki/v4tiny_3class.data syoseki/v4tiny_3class.cfg yolov4-tiny.conv.29 -map -dont_show

	echo "end training"
elif [ "$arg" == "$case_test" ];then
	if [ ! -e "darknet/${path_weights}" ];then
		echo "先に訓練を行ってください"
		exit
	fi
	cd darknet 
	./darknet detector test syoseki/${data} syoseki/${cfg} ${path_weights} syoseki/valid1.jpg -dont_show

else 
	echo "引数はtrainかtestにしてください"
	exit
fi
