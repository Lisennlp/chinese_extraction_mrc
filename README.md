# 项目说明

项目是基于Pytorch + BERT做的一个抽取式中文机器阅读理解系统

# 数据集

dureader2.0

# 训练

    cd script 
    sh train.sh train

# 预测

    cd script 
    sh train.sh predict

预测的结果在./output_dir/predictions.json中


# 其他

说明下本项目关键的几个地方：

- start position  
    我们输入的是段落中的字的索引，需要转化为tokenizer之后的索引，并且，还需要加上query token 的长度。
- end position 
    和start position同理  
- 长度超过max_seq_length
    对于太长的句子，采用了划窗策略，即按照一定的长度对文本进行拆分，然后再检查答案是否在对应的窗口文本中，如果在则改变相应的起末位置索引；如果不在，则起末位置索引置0
- 计算loss的时候，忽略了>=max_seq_length的label和小于0的label。
- 防止处理出错，对label进行了clamp操作，小于0的置0，大于max_seq_length置max_seq_length。
