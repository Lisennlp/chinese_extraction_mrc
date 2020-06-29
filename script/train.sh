#! /bin/sh

if [ "$1" = "train" ]; then
        echo "start to train......"
        CUDA_VISIBLE_DEVICES=0,1  python -W ignore::UserWarning -W ignore::SourceChangeWarning ../chinese_extraction_mrc/train.py  \
                        --train_file ../data/small.zhidao.train.json \
                        --predict_file ../data/small.zhidao.dev.json \
                        --output_dir ./output_dir  \
                        --bert_model /nas/pretrain-bert/pretrain-pytorch/bert-base-chinese/ \
                        --train_batch_size 16  \
                        --num_train_epochs 3 \
                        --do_train  \
                        3>&2 2>&1 1>&3 |tee train.log


elif [ "$1" = "predict" ]; then
        echo "start to predict......"
        CUDA_VISIBLE_DEVICES=0 python -W ignore::UserWarning -W ignore::SourceChangeWarning ../chinese_extraction_mrc/train.py  \
                        --predict_file ../data/small.zhidao.dev.json \
                        --output_dir ./output_dir  \
                        --bert_model /nas/pretrain-bert/pretrain-pytorch/bert-base-chinese/ \
                        --do_predict  \
                        --predict_batch_size 16  \
                        3>&2 2>&1 1>&3 |tee predict.log

else
    echo 'unknown argment 1'
fi

