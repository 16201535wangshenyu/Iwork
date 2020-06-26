<template>
<!--1.综合信息统计：
年龄分布（20以内；20-30；30-40；40-50；50-60），
工资分布（1k-5k；5k-10k；10k-15k；15k-20k；20k-25k；25k-30k；30k-40k；40k-50k；50k-100k；100k-200k；200k以上），
各部门产值（部门，部门当年产值），
年度生产总值变化（每年总产值/亿）
-->
    <el-col>
        <el-row>
            <el-col :span="10">
                <!-- /statistics/comprehensive/empAge -->
                <nightingale-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/CompSta/age" 
                    titletext="员工年龄分布" dataname="员工年龄分布"></nightingale-chart>
            </el-col>
            <el-col :span="14" >
                <!-- /statistics/comprehensive/empSalary -->
                <bar-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/CompSta/Salary" 
                    titletext="员工薪资分布" 
                    :legdata="['员工薪资']"  xname="薪资/元" 
                    :xdata="['1k-5k','5k-10k','10k-20k','20k-30k','30k-40k','40k-50k','50k-100k','100k-1000k']" yname="薪资数/元">
                </bar-chart>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="24">
                <!-- /statistics/comprehensive/comDepartPrdtValue -->
                <bar-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/CompSta/Part"
                     titletext="各部门年产值" 
                    :legdata="['各部门年产值']" xname="部门名称" 
                    :xdata="['股东会','董事会','总办','财务部','市场部','华北市场部',
                    '华南市场部','西北市场部','西安市场','技术部',
                    '运维部']" yname="年产值/十万元"></bar-chart>
            </el-col>
        </el-row>
        <el-row>
            <el-col :span="24">
                <!-- /statistics/comprehensive/comPrdtValue -->
                <line-chart inpath="https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/CompSta/All" 
                    titletext="公司近10年产值" 
                    :legdata="['公司年产值']" xname="年份" 
                    :xdata="['2009','2010','2011','2012','2013','2014','2015','2016','2017','2018']" yname="年产值/十万"></line-chart>
            </el-col>
        </el-row>
    </el-col>
</template>
<script>
    import lineChart from '../components/chart/LineChart'
    import nightingaleChart from '../components/chart/NightingaleChart'
    import barChart from '../components/chart/BarChart'
    export default {
        components: {
            lineChart,
            nightingaleChart,
            barChart
        },
        data() {
            return {
                path:"https://result.eolinker.com/8DLIneUc2d20de5971becf7991b5a73317f4aad77e2139e?uri=/CompSta",
                agepath:this.path+"/age",
                salpath:this.path+"/Salary",
                deppath:this.path+"/Part",
                compath:this.path+"/All"
            }
        }
    }
</script>
<!--<style src="../../../static/vue-f-calendar.css"></style>-->