<template>
  <div class="per-leave__wrap">
    <el-tabs type="border-card">
      <el-tab-pane label="正在出差">
        <!--        <el-dialog class="block" :visible.sync="dialogFormVisible" title="申请出差">-->
        <!--          <el-form ref="form" :model="form" label-width="80px">-->
        <!--            <el-form-item label="选择日期">-->
        <!--              <el-date-picker-->
        <!--                v-model="value1"-->
        <!--                type="daterange"-->
        <!--                range-separator="至"-->
        <!--                start-placeholder="开始日期"-->
        <!--                end-placeholder="结束日期">-->
        <!--              </el-date-picker>-->
        <!--            </el-form-item>-->
        <!--            <el-form-item label="申请内容">-->
        <!--              <el-input-->
        <!--                placeholder="请输入内容"-->
        <!--                v-model="input"-->
        <!--                clearable>-->
        <!--              </el-input>-->
        <!--            </el-form-item>-->
        <!--            <el-form-item class="dialog-footer">-->
        <!--              <el-button @click="dialogFormVisible = false">取 消</el-button>-->
        <!--              <el-button type="primary" @click="dialogFormVisible = false">确 定</el-button>-->
        <!--            </el-form-item>-->
        <!--          </el-form>-->
        <!--        </el-dialog>-->
        <el-table
          ref="filterTable"
          :data="tableData"
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
            label="姓名"
            width="180">
          </el-table-column>
          <el-table-column
            prop="address"
            label="出差详情"
            :formatter="formatter">
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
        <div class="block">
          <el-pagination
            background
            layout="prev, pager, next"
            :total="1">
          </el-pagination>
        </div>
      </el-tab-pane>
      <el-tab-pane label="申请审核">
        <div style="margin-top: 20px">
          <el-button @click="toggleSelection([tableData[1], tableData[2]])">通过已选</el-button>
          <el-button @click="toggleSelection()">拒绝已选</el-button>
        </div>
        <el-table
          ref="multipleTable"
          :data="tableData2"
          tooltip-effect="dark"
          style="width: 100%"
          @selection-change="handleSelectionChange">
          <el-table-column
            type="selection"
            width="55">
          </el-table-column>
          <el-table-column
            label="日期"
            width="120">
            <template slot-scope="scope">{{ scope.row.date }}</template>
          </el-table-column>
          <el-table-column
            prop="name"
            label="姓名"
            width="120">
          </el-table-column>
          <el-table-column
            prop="address"
            label="出差详情"
            show-overflow-tooltip>
          </el-table-column>
          <el-table-column
            prop="startTime"
            label="开始时间">
          </el-table-column>
          <el-table-column
            prop="endTime"
            label="结束时间">
          </el-table-column>
          <el-table-column
            prop="tag"
            label="标签"
            width="100"
            filter-placement="bottom-end">
            <template slot-scope="scope">
              <el-tag
                :type="scope.row.tag === '未审核' ? 'danger' : 'success'"
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
      <el-tab-pane label="已审核列表">
        <div style="margin-top: 20px">
          <el-button @click="revokeSelection()">撤销已选</el-button>
        </div>
        <el-table
          ref="multipleTable2"
          :data="tableData3"
          tooltip-effect="dark"
          style="width: 100%"
          @selection-change="handleSelectionChange2">
          <el-table-column
            type="selection"
            width="55">
          </el-table-column>
          <el-table-column
            label="日期"
            width="120">
            <template slot-scope="scope">{{ scope.row.date }}</template>
          </el-table-column>
          <el-table-column
            prop="name"
            label="姓名"
            width="120">
          </el-table-column>
          <el-table-column
            prop="address"
            label="出差详情"
            show-overflow-tooltip>
          </el-table-column>
          <el-table-column
            prop="startTime"
            label="开始时间">
          </el-table-column>
          <el-table-column
            prop="endTime"
            label="结束时间">
          </el-table-column>
          <el-table-column
            prop="tag"
            label="标签"
            width="100"
            :filters="[{ text: '已通过', value: '已通过' }
              , { text: '已拒绝', value: '已拒绝' }]"
            :filter-method="filterTag"
            filter-placement="bottom-end">
            <template slot-scope="scope">
              <el-tag
                :type="scope.row.tag === '已拒绝' ? 'danger' : 'success'"
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
  import {getRequest, postRequest} from "../../utils/api";

  export default {
    data() {
      return {
        input: '',
        value1: '',
        form: {},
        tableData: [],
        tableData2: [],
        tableData3: [],
        multipleSelection: [],
        multipleSelection2: [],
        dialogFormVisible: false
      }
    },
    mounted() {
      this.initData()
    },
    methods: {
      initData() {
        this.emptyData();
        getRequest('/evaluat/records', 'json')
          .then(response => {
            response.data.forEach((item) => {
              let applyDate = item.applyDate
              let realName = item.applyPerson.realName
              let applyReason = item.applyReason
              let leaveType = item.leavetype.leaveType
              let state = item.state
              let startTime = item.startTime
              let endTime = item.endTime
              let leaveId = item.leaveId
              // let {
              //   applyDate: applyDate
              //   , applyPerson: {realName}
              //   , applyReason: applyReason
              //   , leavetype: {leaveType}
              //   , startTime
              //   , endTime
              //   , state
              //   , leaveId
              // } = item

              if (leaveType === '出差') {

                console.log(state)
                if (state === 0) {
                  this.tableData.push({
                    date: applyDate.slice(0, applyDate.indexOf('T')),
                    name: realName,
                    address: applyReason,
                    startTime: startTime.slice(0, startTime.indexOf('T')),
                    endTime: endTime.slice(0, endTime.indexOf('T')),
                    leaveId
                  })
                } else if (state === 2) {
                  this.tableData2.push({
                    date: applyDate.slice(0, applyDate.indexOf('T')),
                    name: realName,
                    address: applyReason,
                    tag: '未审核',
                    startTime: startTime.slice(0, startTime.indexOf('T')),
                    endTime: endTime.slice(0, endTime.indexOf('T')),
                    leaveId
                  })
                }
                if (state !== 2) {
                  this.tableData3.push({
                    date: applyDate.slice(0, applyDate.indexOf('T')),
                    name: realName,
                    address: applyReason,
                    tag: function (state) {
                      let temp = ''
                      switch (state) {
                        case 0:
                          temp = '已通过';
                          break;
                        case 1:
                          temp = '已拒绝';
                          break;
                        case 2:
                          temp = '未审核';
                          break;
                      }
                      return temp
                    }(state),
                    startTime: startTime.slice(0, startTime.indexOf('T')),
                    endTime: endTime.slice(0, endTime.indexOf('T')),
                    leaveId
                  })
                }
              }

            })
          })
          .catch(error => {
            console.log(error)
          })
      },
      emptyData(){
          this.tableData= [],
          this.tableData2= [],
          this.tableData3= [],
          this.multipleSelection= [],
          this.multipleSelection2= []

      },
      revokeSelection() {
        console.log('revokeSelection')
        if (this.multipleSelection2) {
          console.log(this.multipleSelection2)
          console.log(this.multipleSelection)
          let arr = []
          let list = []
          this.multipleSelection2.forEach((item, index) => {
            list.push(item.leaveId)
            console.log('index : ' + index)
            arr.push(index)
          })
          postRequest('/evaluat/trip/revoke', {
            list: list,
          })
            .then(response => {
              console.log('response')
              console.log(arr)

              arr.reverse().forEach((value, index) => {
                let i = Number.parseInt(value)
                console.log(value);
                console.log(index);
                console.log(i)
                console.log(this.tableData3.length)
                this.tableData3.splice(i, i + 1)
                console.log(this.tableData3.length)
              })
              this.$refs.multipleTable2.clearSelection();
              this.initData();
            })
            .catch(error => {
              console.log(error)
            })
        }
      },
      toggleSelection(flag) {
        if (flag) {
          if (this.multipleSelection) {
            let arr = []
            let list = []
            this.multipleSelection.forEach((item, index) => {
              list.push(item.leaveId)
              arr.push(index)
            })
            postRequest('/evaluat/trip/pass', {
              list: list,
            })
              .then(response => {
                console.log('response')
                console.log(response)
                arr.reverse().forEach((value => {
                  let i = Number.parseInt(value)
                  this.tableData2.splice(i, i + 1)
                }))
                this.$refs.multipleTable.clearSelection();
                this.initData();
              })
              .catch(error => {
                console.log(error)
              })
          }

          // 向后台发起数据，讲申请变为已撤销
        } else {
          if (this.multipleSelection) {
            let arr = []
            let list =[]
            this.multipleSelection.forEach((item, index) => {
              list.push(item.leaveId)
              arr.push(index)
            })
            postRequest('/evaluat/trip/deny', {
              list: list,
            })
              .then(response => {
                console.log('response')
                console.log(response)
                arr.reverse().forEach((value => {
                  let i = Number.parseInt(value)
                  this.tableData2.splice(i, i + 1)
                }))
                this.$refs.multipleTable.clearSelection();
                this.initData();
              })
              .catch(error => {
                console.log(error)
              })
          }

        }
      },
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      handleSelectionChange2(val) {
        this.multipleSelection2 = val;
      },
      resetDateFilter() {
        this.$refs.filterTable.clearFilter('date');
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
  .per-leave__wrap {
    margin-top: 10px;
    text-align: left;
  }
</style>
