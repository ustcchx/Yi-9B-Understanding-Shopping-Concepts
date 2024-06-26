## 微调Yi-9B模型增强模型购物概念理解能力
### 0. 实验基本说明
本次实验是深度学习实验大作业，团队成员分别为：
- 陈鸿绪 （负责GPT生成数据异步并发实现、构建微调数据集与数据处理、模型训练微调与测试、项目构建与实验报告撰写）
- 黄祈铭 （负责生成GPT数据、构建微调数据集、数据处理、实验报告撰写）
- 林博文 （构建微调数据集、数据处理、实验报告撰写）

我们团队的选题为"Amazon KDD Cup 24: Understanding Shopping Concepts"，由于我们使用了9B的大模型Yi-9B，单个样本推理（大致16GB）加上模型所占显存（大概18GB）在2张T4显卡（32GB显存）在不采取量化操作的情况下明显会OOM，然而量化会导致模型性能的下降，所以本次实验采取自行划分数据集与任务类型进行评测。实验显卡采用6张3090显卡并行微调训练，2张3090并行推理。
### 1. 项目文件夹说明
- bash：存放linux系统训练、测试、导出模型的.sh脚本
- data：存放post-pre-train数据集（三个不同语料数据集下载地址），sft数据集（GPT生成数据集代码与huggingface数据集下载地址），测试数据集test-data（包括6种不同大类型任务）
- fig：训练时的测试集与验证集loss图像
- LLaMA-Factory：微调框架
- report：任务报告
- slurm-out：提交作业后的计算节点输出
- test-result：测试输出结果处理，其中有两个子文件夹，分别存储原模型和微调后模型在六种不同类型的任务上的测试输出与相应指标。
### 2. 实验过程简单说明
1. 构建数据集：分为post-pre-trainning的数据集与SFT数据集，两种数据集的组成在文件夹中可见。
2. 数据处理：这部分包括了数据去空、SFT数据构建、数据筛查、输出规范化、数据集划分、数据标注等操作。
3. 训练微调：使用相应的数据集进行两步训练，分别为post pre-trainning（特定领域再次lora预训练以学习相关知识）与self-supervised trainnning（对于一些特定下游任务进行lora微调），我们使用了6张3090显卡、利用LLaMa-Factory框架进行了分布式微调。
4. 模型测试：对于不同的任务类型我们将采用不同的指标进行评测，这里还需要对于大模型输出需要进行基于规则式的答案提取。

### 3. 微调后模型性能与微调前的性能比较
对于每一个任务，我们都会随机筛选出上百条数据进行在原模型和微调后模型上的测试。由于对于大模型的输出不能保证其格式的稳定性，所以在析取答案时采取基于规则式析取和人工析取，对于无法有效析取的输出采取最差指标进行标记。由于我们精力有限，在ranking测试集上的原模型输出格式过于繁杂、迷惑，所以这部分的指标采用'-'代替。最后我们在各类测试集上的测试结果以及指标如下表所示，可以看见经过post-pretrain与SFT后的模型表现显著优异于原模型。

</style>
<table class="tg"><thead>
  <tr>
    <th class="tg-0pky"></th>
    <th class="tg-0pky">CLS</th>
    <th class="tg-0pky">NRE</th>
    <th class="tg-0pky">Ranking</th>
    <th class="tg-0pky" colspan="2">Generation</th>
    <th class="tg-0pky">multi-choice</th>
    <th class="tg-0pky">retrieval</th>
  </tr></thead>
<tbody>
  <tr>
    <td class="tg-0pky">Metric</td>
    <td class="tg-0pky">ACC</td>
    <td class="tg-0pky">Micro-F1/average</td>
    <td class="tg-0pky">NDCG@4/average</td>
    <td class="tg-0pky">bleu-4</td>
    <td class="tg-0pky">rouge-l</td>
    <td class="tg-0pky">ACC</td>
    <td class="tg-0pky">Hit@3/average</td>
  </tr>
  <tr>
    <td class="tg-0pky">Yi-9B</td>
    <td class="tg-0pky">15.63%</td>
    <td class="tg-0pky">0.00</td>
    <td class="tg-0pky">---</td>
    <td class="tg-0pky">13.03</td>
    <td class="tg-0pky">10.55</td>
    <td class="tg-0pky">34.66%</td>
    <td class="tg-0pky">1.028</td>
  </tr>
  <tr>
    <td class="tg-0pky">Fine-tuned Yi-9B</td>
    <td class="tg-0pky">75.00%</td>
    <td class="tg-0pky">0.73</td>
    <td class="tg-0pky">1.082</td>
    <td class="tg-0pky">40.59</td>
    <td class="tg-0pky">36.24</td>
    <td class="tg-0pky">80.11%</td>
    <td class="tg-0pky">2.271</td>
  </tr>
</tbody></table>


### Huggingface
我们的模型已经上传至huggingFace：
[Model URL](https://huggingface.co/Daxuxu36/Yi-9B-Understanding-Shopping-Concepts)