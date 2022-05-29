<template>
  <div class="home">
<!--    功能区-->
    <div style="margin: 10px 0">
      <el-button type="primary" @click="add">新增</el-button>
<!--      <el-button type="primary">导入</el-button>-->
<!--      <el-button type="primary">导出</el-button>-->
    </div>

<!--    搜索区-->
    <div>
      <el-input v-model="search" placeholder="请输入搜索内容" style="width: 30%" clearable></el-input>
      <el-button type="primary" style="margin-left: 5px" @click="load">查询</el-button>
    </div>
    <el-table
          :data="tableData"
          border
          stripe
          style="width: 100%; align-content: center">
      <el-table-column prop="id" label="ID" sortable />
      <el-table-column prop="title" label="标题" sortable />
      <el-table-column prop="author" label="作者" sortable />
      <el-table-column prop="time" label="出版时间" sortable />
      <el-table-column
          fixed="right"
          label="操作">
        <template #default="scope" style="margin-right: 4px; z-index: 0; display: flex; align-items: center">
          <el-button size="small" @click="details(scope.row)">详情</el-button>
          <el-button size="small" @click="handleEdit(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除吗？" @confirm="handleDelete(scope.row.id)">
            <template #reference>
              <el-button size="small" type="danger">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="margin: 10px 0">
      <el-pagination
          v-model:currentPage="currentPage"
          v-model:page-size="pageSize"
          @current-change="handleCurrentChange"
          @size-change="handleSizeChange"
          :current-page="currentPage"
          :page-sizes="[5, 10, 20, 50]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
      />

<!--      弹窗-->
      <el-dialog title="提示" v-model="dialogVisible" width="60%">
        <el-form :model="form" label-width="120px">
          <el-form-item label="标题">
            <el-input v-model="form.title" style="width: 40%"></el-input>
          </el-form-item>
          <div id="div1"></div>
        </el-form>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
          </span>
        </template>
      </el-dialog>

<!--      详情弹窗-->
      <el-dialog title="详情" v-model="vis" width="60%">
        <el-card>
          <div v-html="detail.content" style="min-height: 100px"></div>
        </el-card>
      </el-dialog>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import request from "@/utils/request";
import E from 'wangeditor'
import {Discount} from "@element-plus/icons-vue";

let editor;

export default {
  name: 'news-view',
  components: {
    Discount
  },
  data() {
    return {
      form: {},
      dialogVisible: false,
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [],
      vis: false,
      detail: {}
    }
  },
  created() {
    this.load()
  },
  methods :{
    filesUploadSuccess(res) {
      console.log(res)
      this.form.cover = res.data
    },
    load() {
      request.get("news", {
        params: {
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          search: this.search
        }
      }).then(res => {
        console.log(res)
        this.tableData = res.data.records
        this.total = res.data.total
        this.pageSize = res.data.size
      })
    },
    add() {
      this.dialogVisible = true;
      this.form = {}
      if (this.$refs['upload']) {
        this.$refs['upload'].clearFiles()
      }
      this.$nextTick(() => {
        editor = new E('#div1')

        // 配置 server 接口地址
        editor.config.uploadImgServer = '/files/upload'

        editor.create()
      })
    },
    save() {
      this.form.content = editor.txt.html() // 获取编辑器内的值，赋予到实体当中
      if (this.form.id) { //更新
        request.put("/news", this.form).then(res => {
          console.log(res)
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "更新成功"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.dialogVisible = false
          this.load()
        })
      } else { //添加
        let userStr = sessionStorage.getItem("user") || "{}"
        let user = JSON.parse(userStr)
        this.form.author = user.nickName
        request.post("/news", this.form).then(res => {
          console.log(res)
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "新增成功"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.dialogVisible = false
          this.load()
        })
      }
    },
    details(row) {
      this.detail = row
      this.vis = true
      this.$nextTick(() => {
        editor = new E('#div1')
        editor.create()
        editor.txt.html(row.content)
      })
    },
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
      this.$nextTick(() => {
        editor = new E('#div1')
        editor.create()
        editor.txt.html(row.content)
      })
    },
    handleDelete(id) {
      console.log(id)
      request.delete("/news/" + id).then(res => {
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "新增成功"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.load()
      })
    },
    handleSizeChange() {
      this.load()
    },
    handleCurrentChange() {
      this.load()
    }
  }
}
</script>
