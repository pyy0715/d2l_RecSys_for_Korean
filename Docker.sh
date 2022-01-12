docker run -d --gpus=all -it --ipc=host \
	-p 18888:8888 \
    -v $(pwd):/home/d2l_student \
	yyeon/d2l_study:cu101
