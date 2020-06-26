<template>
  <div class="per-leave__wrap">
    <el-tabs type="border-card">
      <el-tab-pane label="历史记录">
        <el-table
          ref="filterTable"
          :data="evaluatRecord"
          style="width: 100%">
          <el-table-column
            prop="date"
            label="日期"
            sortable
            width="180"
            column-key="date"
          >
          </el-table-column>
          <el-table-column
            prop="name"
            width="180"
            label="姓名">
          </el-table-column>
          <el-table-column
            prop="result"
            width="180"
            label="结果">
          </el-table-column>
          <el-table-column
            prop="tips"
            label="备注"
            width="180">
          </el-table-column>
        </el-table>
        <div class="block">
          <el-pagination
            background
            layout="prev, pager, next"
            :total="1">
          </el-pagination>
        </div>
      </el-tab-pane>
      <el-tab-pane label="候选评优">
        <el-form ref="form" :model="form" label-width="80px" style="padding: 20px 160px">
          <el-form-item label="候选人">
            <el-select v-model="value" filterable placeholder="请选择">
              <el-option
                v-for="item in this.options"
                :key="item.value"
                :label="item.label"
                :value="item.value">
              </el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="考评内容">
            <el-input
              placeholder="考评内容"
              v-model="form.content"
              clearable>
            </el-input>
          </el-form-item>
          <el-form-item label="考评结果">
            <el-input
              placeholder="考评结果"
              v-model="form.result"
              clearable>
            </el-input>
          </el-form-item>
          <el-form-item label="备注">
            <el-input
              placeholder="备注"
              v-model="form.tips"
              clearable>
            </el-input>
          </el-form-item>

          <el-form-item class="dialog-footer">
            <el-button type="primary" @click="submitAppraise()">提交</el-button>
          </el-form-item>
        </el-form>

      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
  import {getRequest, postRequest} from '../../utils/api'

  export default {
    data() {
      return {

        value: '',
        options: [],
        form: {
          result: '',
          user: '',
          tips: '',
          content: '',
        },
        evaluatRecord: [],
        evaluatCandidate: [],
        multipleSelection: []
      }
    },
    methods: {
      submitAppraise() {
        console.log(this.value)
        console.log('this.value')
        console.log(this.form)
        this.form.result = 'ccccc'
        postRequest('/evaluat/appraise/insert', {
          user: this.value,
          appResult: this.form.result,
          appContent: this.form.content,
          remark: this.form.tips

        })
          .then(response => {
            alert('评价成功')
            this.form = {
              result: '',
              user: '',
              tips: '',
              content: '',
            }
            console.log(response)
          })
          .catch(error => {
            console.log(error)
          })
      },
      filterTag(value, row) {
        return row.tag === value;
      },
    },
    mounted() {
      getRequest('/evaluat/appraise/users', 'json')
        .then(response => {
          response.data.forEach((item) => {
            this.options.push({
              value: item.userUid,
              label: item.realName
            })
          })
        })
        .catch(error => {
          console.log(error)
        })
      getRequest('/evaluat/appraise', 'json')
        .then(response => {
          console.log(response)
          response.data.forEach((item) => {
            console.log(item)
            let {
              appDate: date
              , user: {realName: name}
              , appResult: result
              , remark: tips
            } = item
            this.evaluatRecord.push({
              date: date.slice(0, date.indexOf('T')),
              name,
              result,
              tips
            })
          })
        })
        .catch(error => {
          console.log(error)
        })
      console.log('我挂在了 perEva')

      this.evaluatCandidate = [{
        date: '2016-05-02',
        name: '王小虎',
        address: '上海市普陀区金沙江路 1518 弄',
        tag: '未通过'
      }]
      console.log()
    }
  }

</script>

<style scoped>
  .per-leave__wrap {
    margin-top: 10px;
    text-align: left;
  }
</style>
