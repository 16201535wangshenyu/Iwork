<template>
    <el-dialog title="待办事项" center :show-close='false' :visible.sync="isAdd" width="500px">
        <el-form ref="formDetail" :model="formDetail" :rules="rules" label-width="60px" class="demo-ruleForm">
            <el-form-item label="内容" prop="title">
                <el-input v-model="formDetail.title" type="textarea"></el-input>
            </el-form-item>
            <el-form-item label="日期" prop="period">
                <el-date-picker v-model="formDetail.period" value-format='yyyy-MM-dd' type="daterange" range-separator="至" start-placeholder="开始日期" end-placeholder="结束日期">
                </el-date-picker>
            </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
                    <el-button type="primary" @click="submit">确 定</el-button>
                    <el-button  @click="destoryI" type="warning" :disabled="isDisabled" plain>删  除</el-button>
                    <el-button @click="turnOff">取 消</el-button>
                </span>
    </el-dialog>
</template>
<script>
    export default {
        props: ['isAdd', 'editItem', 'destoryItem', 'events'],
        data() {
            return {
                isDisabled:this.editItem.id?false:true,
                rules: {
                    title: [{
                        required: true,
                        message: '请输入内容'
                    }, ],
                    period: [{
                        required: true,
                        message: '请输入日期'
                    }, ]
                },
                formDetail: {
                    title: '',
                    period: []
                }
            }
        },
        created() {
            if (this.editItem.id) { //编辑
                this.formDetail.title = this.editItem.title
                this.formDetail.period[0] = this.editItem.start._i
                this.formDetail.period[1] = this.editItem.end ? this.editItem.end._i : this.editItem.start._i
            }
        },
        methods: {
            submit() {
                this.$refs['formDetail'].validate((valid) => {
                    if (valid) {
                        this.$emit('add', JSON.stringify(this.formDetail))
                        this.$emit('close')
                    }
                })
            },
            destoryI: function() {
                this.$confirm('此操作将永久删除全部日程, 是否继续?', '提示', {
                    confirmButtonText: '确定',
                    cancelButtonText: '取消',
                    type: 'warning'
                }).then(() => {
                    if (this.editItem.id) { //如果是存在，就删掉该条
                    this.events.forEach((el, ind) => {
                        if (el.id == this.editItem.id) {
                            console.log(ind)
                            this.events.splice(ind, 1)
                        }
                    })
                    console.log(this.events)
                    this.$emit('close')
                }
                localStorage.setItem('ents', JSON.stringify(this.events));
                    this.$message({
                        type: 'success',
                        message: '删除成功!'
                    });
                }).catch(() => {
                    this.$message({
                        type: 'info',
                        message: '已取消删除'
                    });
                });
                
            },
            turnOff() {
                this.$emit('close')
            }
        }
    }
</script>
<style lang="" scoped>
    .el-date-editor {
        width: 100%;
    }
</style>