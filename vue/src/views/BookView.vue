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
      <el-table-column prop="name" label="书名" sortable />
      <el-table-column prop="price" label="价格" sortable />
      <el-table-column prop="author" label="作者" sortable />
      <el-table-column prop="createTime" label="出版时间" sortable />
      <el-table-column label="封面">
        <template #default="scope">
          <el-image
            style="width: 100px; height: 100px"
            :src="scope.row.cover"
            preview-teleported="true"
            :preview-src-list="[scope.row.cover]"
            :initial-index="4"
            fit="cover"
          />
        </template>
      </el-table-column>
      <el-table-column prop="lend" label="是否出借" sortable />
      <el-table-column prop="borrower" label="借书人" sortable />
      <el-table-column
          fixed="right"
          label="操作">
        <template #default="scope" style="margin-right: 4px; z-index: 0; display: flex; align-items: center">
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

      <el-dialog title="提示" v-model="dialogVisible" width="30%">
        <el-form :model="form" label-width="120px">
          <el-form-item label="书名">
            <el-input v-model="form.name" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="价格">
            <el-input v-model="form.price" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="作者">
            <el-input v-model="form.author" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="出版时间">
            <el-date-picker value-format="YYYY-MM-DD" type="date" v-model="form.createTime" style="width: 80%"></el-date-picker>
          </el-form-item>
          <el-form-item label="封面">
            <el-upload ref="upload" action="http://localhost:9090/files/upload" :on-success="filesUploadSuccess">
              <el-button type="primary">Click to upload</el-button>
            </el-upload>
          </el-form-item>
          <el-form-item label="出借状态">
            <el-radio v-model="form.lend" label="出借中">出借中</el-radio>
            <el-radio v-model="form.lend" label="未出借">未出借</el-radio>
          </el-form-item>
          <el-form-item label="借书人">
            <el-input v-model="form.borrower" style="width: 80%"></el-input>
          </el-form-item>
        </el-form>
        <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
          </span>
        </template>
      </el-dialog>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import request from "@/utils/request";

export default {
  name: 'book-view',
  components: {
  },
  data() {
    return {
      form: {},
      dialogVisible: false,
      search: '',
      currentPage: 1,
      pageSize: 10,
      total: 0,
      tableData: [
      ]
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
      request.get("book", {
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
    },
    save() {
      if (this.form.id) { //更新
        request.put("/book", this.form).then(res => {
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
        request.post("/book", this.form).then(res => {
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
    handleEdit(row) {
      this.form = JSON.parse(JSON.stringify(row))
      this.dialogVisible = true
      this.$nextTick(() => {
        if (this.$refs['upload']) {
          this.$refs['upload'].clearFiles()
        }
      })
    },
    handleDelete(id) {
      console.log(id)
      request.delete("/book/" + id).then(res => {
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
