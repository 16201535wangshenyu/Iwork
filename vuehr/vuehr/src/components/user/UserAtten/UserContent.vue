<template>
  <div class="content">
    <el-table
      :data="tableData"
      style="width: 100%">
      <el-table-column
        prop="date"
        label="日期"
        width="180">
      </el-table-column>
      <el-table-column
        prop="address"
        label="申請内容">
      </el-table-column>
      <el-table-column
        prop="startTime"
        label="开始时间">
      </el-table-column>
      <el-table-column
        prop="endTime"
        label="结束时间">
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
  import {getRequest, postRequest} from "../../../utils/api";

  export default {
    name: 'UserContent',
    data() {
      return {
        tableData: []
      }
    },
    mounted() {
      this.init()

    },
    methods: {
      init() {
        getRequest('/user/leaves/001', 'json')
          .then(response => {
            console.log(response)
            response.data.forEach((item) => {
              let {
                applyDate: applyDate
                , applyPerson: {realName}
                , applyReason: applyReason
                , leavetype: {leaveType}
                , approver: {realName: approverName}
                , state
                , startTime
                , endTime
                , leaveId
              } = item

              this.tableData.push({
                date: applyDate.slice(0, applyDate.indexOf('T')),
                name: realName,
                address: applyReason,
                tag: leaveType,
                approverName,
                startTime: startTime.slice(0, startTime.indexOf('T')),
                endTime: endTime.slice(0, endTime.indexOf('T')),
                leaveId
              })

            })
          })
          .catch(error => {
            console.log(error)
          })
      }
    }
  }
</script>

<style scoped>
  .content {
    background: #fff;
    vertical-align: top;
    display: inline-block;
    width: 850px;
    height: 935px;
    margin-left: 20px;
    overflow-y: auto;
    overflow: hidden;
  }

  .content-main {
    margin: 20px;
    text-align: left;
  }
</style>
