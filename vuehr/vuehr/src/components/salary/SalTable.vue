<template>
  <div>
    <el-container>
      <el-header style="text-align: left;padding-left: 0px;margin-top: 10px">
        <el-tag size="medium">请选择部门:</el-tag>
        <el-select size="mini" v-model="depId" placeholder="请选择">
          <el-option
            v-for="item in deps"
            :key="item.departmentUid"
            :label="item.name"
            :value="item.departmentUid">
          </el-option>
        </el-select>
      </el-header>
      <el-main>Main</el-main>
    </el-container>
  </div>
</template>
<script>
  export default{
    data(){
      return {
        depId: 1,
        deps: []
      }
    },
    methods: {
      loadDeps(){
        var _this = this;
        this.getRequest("/salary/table/deps").then(resp=> {
          if (resp && resp.status == 200) {
            console.log("加载的部门工资表")
            console.log(resp.data)
            _this.deps = resp.data;
          }
        })
      }
    },
    mounted:function () {
      this.loadDeps();
    }
  }
</script>
