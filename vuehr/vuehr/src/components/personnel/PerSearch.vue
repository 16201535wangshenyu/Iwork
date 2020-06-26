<template>
  <div class="per-leave__wrap">
    <el-tabs type="border-card">
      <el-tab-pane label="考勤记录">
        <el-table
          ref="filterTable"
          :data="tableData">
          <el-table-column
            prop="date"
            label="时间"
            sortable
            width="240"
            column-key="date"
          >
          </el-table-column>
          <el-table-column
            prop="name"
            label="姓名"
            width="180">
          </el-table-column>
          <el-table-column
            prop="department"
            label="所属部门">
          </el-table-column>
          <el-table-column
            prop="position"
            label="职位">
          </el-table-column>
          <el-table-column
            prop="tag"
            label="标签"
            width="100"
            :filters="[{ text: '出勤', value: '出勤' }, { text: '迟到', value: '迟到' }
              ,{ text: '早退', value: '早退' }, { text: '旷到', value: '旷到' }]"
            :filter-method="filterTag"
            filter-placement="bottom-end">
            <template slot-scope="scope">
              <el-tag
                :type="scope.row.tag === '出勤' ? 'primary' : 'success'"
                disable-transitions>{{scope.row.tag}}
              </el-tag>
            </template>
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
    </el-tabs>
  </div>
</template>

<script>
  import {getRequest} from "../../utils/api";

  export default {
    data() {
      return {
        tableData: []
      }
    },
    mounted() {


      getRequest('/evaluat/checks', 'json')
        .then(response => {
          console.log(response)
          response.data.forEach((item) => {
            console.log("hahahahaha")
            console.log(item)
            let {
              date
              , user: {realName}
              , user: {oweDepartment: {name: department}}
              , user: {position: {name: position}}
              , type: tag
            } = item
            this.tableData.push({ date: date.slice(0, date.indexOf('.')).replace(/T/g, ' ')
              , name: realName
              , department
              , position
              , tag
            })

          })

        })
        .catch(error => {
          console.log(error)
        })
    },
    methods: {
      toggleSelection(flag) {

      },
      resetDateFilter() {
        this.$refs.filterTable.clearFilter('date');
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      clearFilter() {
        this.$refs.filterTable.clearFilter();
      },
      formatter(row, column) {
        return row.address;
      },
      filterTag(value, row) {
        return row.tag === value;
      },
      filterHandler(value, row, column) {
        const property = column['property'];
        return row[property] === value;
      }
    }
  }
</script>

<style scoped>
  div {
    margin-top: 10px;
    text-align: left;
  }
</style>
