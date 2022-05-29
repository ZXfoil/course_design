<template>
  <div style="width: 100%; height: 100vh; background-color: darkslateblue; overflow: hidden">
    <div style="width: 400px; margin: 150px auto">
      <div style="color:  #ecf5ff; font-size: 30px; text-align: center; padding: 30px 0">欢迎登录</div>
      <el-form ref="form" :model="form" size="large" :rules="rules">
        <el-form-item prop="username">
          <el-input prefix-icon="Avatar" v-model="form.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input prefix-icon="Lock" v-model="form.password" show-password></el-input>
        </el-form-item>
        <el-form-item>
          <el-button style="width: 100%" type="primary" @click="login">登 录</el-button>
        </el-form-item>
            <el-form-item><el-button type="text" @click="$router.push('/register')">前往注册 >> </el-button></el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "LoginView",
  data() {
    return {
      form: {},
      rules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' },
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
        ],
      }
    }
  },
  methods: {
    login() {
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("user/login", this.form).then(res => {
            if (res.code === '0') {
              this.$message({
                type: "success",
                message: "登录成功"
              })
              sessionStorage.setItem("user", JSON.stringify(res.data))
              this.$router.push("/")
            } else {
              this.$message({
                type: "error",
                message: res.msg
              })
            }
          })
        }
      })
    }
  }
}
</script>

<!--<script>-->
<!--import request from "@/utils/request";-->

<!--export default {-->
<!--  name: "LoginView",-->
<!--  data() {-->
<!--    return {-->
<!--      form: {},-->
<!--      rules: {-->
<!--        username: [-->
<!--          { required: true, message: '请输入用户名', trigger: 'blur' },-->
<!--        ],-->
<!--        password: [-->
<!--          { required: true, message: '请输入密码', trigger: 'blur' },-->
<!--        ],-->
<!--      }-->
<!--    }-->
<!--  },-->
<!--  methods: {-->
<!--    login() {-->
<!--      this.$refs['form'].validate((valid) => {-->
<!--        if (valid) {-->
<!--          request.post("user/login", this.form).then(res => {-->
<!--            if (res.code == '0') {-->
<!--              this.$message({-->
<!--                type: "success",-->
<!--                message: "登录成功"-->
<!--              })-->
<!--              this.$router.push("/")-->
<!--            } else {-->
<!--              this.$message({-->
<!--                type: "error",-->
<!--                message: res.msg-->
<!--              })-->
<!--            }-->
<!--          })-->
<!--        }-->
<!--      })-->
<!--    }-->
<!--  }-->
<!--}-->
<!--</script>-->

<!--<script>-->
<!--import request from "@/utils/request";-->
<!--import ValidCode from "@/components/ValidCode";-->
<!--import {activeRouter} from "@/utils/permission";-->

<!--export default {-->
<!--  name: "Login",-->
<!--  components: {-->
<!--    ValidCode,-->
<!--  },-->
<!--  data() {-->
<!--    return {-->
<!--      vedioCanPlay: false,-->
<!--      fixStyle: '',-->
<!--      form: {role: 1},-->
<!--      rules: {-->
<!--        username: [-->
<!--          {required: true, message: '请输入用户名', trigger: 'blur'},-->
<!--        ],-->
<!--        password: [-->
<!--          {required: true, message: '请输入密码', trigger: 'blur'},-->
<!--        ],-->
<!--      },-->
<!--      validCode: ''-->
<!--      // 加背景图片-->
<!--      // bg: {-->
<!--      //   backgroundImage: "url(" + require("@/assets/bg.jpg") + ")",-->
<!--      //   backgroundRepeat: "no-repeat",-->
<!--      //   backgroundSize: "100% 100%"-->
<!--      // }-->
<!--    }-->
<!--  },-->
<!--  mounted() {-->
<!--    sessionStorage.removeItem("user")-->

<!--    window.onresize = () => {-->
<!--      const windowWidth = document.body.clientWidth-->
<!--      const windowHeight = document.body.clientHeight-->
<!--      const windowAspectRatio = windowHeight / windowWidth-->
<!--      let videoWidth-->
<!--      let videoHeight-->
<!--      if (windowAspectRatio < 0.5625) {-->
<!--        videoWidth = windowWidth-->
<!--        videoHeight = videoWidth * 0.5625-->
<!--        this.fixStyle = {-->
<!--          height: windowWidth * 0.5625 + 'px',-->
<!--          width: windowWidth + 'px',-->
<!--          'margin-bottom': (windowHeight - videoHeight) / 2 + 'px',-->
<!--          'margin-left': 'initial'-->
<!--        }-->
<!--      } else {-->
<!--        videoHeight = windowHeight-->
<!--        videoWidth = videoHeight / 0.5625-->
<!--        this.fixStyle = {-->
<!--          height: windowHeight + 'px',-->
<!--          width: windowHeight / 0.5625 + 'px',-->
<!--          'margin-left': (windowWidth - videoWidth) / 2 + 'px',-->
<!--          'margin-bottom': 'initial'-->
<!--        }-->
<!--      }-->
<!--    }-->
<!--    window.onresize()-->
<!--  },-->
<!--  methods: {-->
<!--    canplay() {-->
<!--      this.vedioCanPlay = true-->
<!--    },-->
<!--    // 接收验证码组件提交的 4位验证码-->
<!--    createValidCode(data) {-->
<!--      this.validCode = data-->
<!--    },-->
<!--    login () {-->
<!--      this.$refs['form'].validate((valid) => {-->
<!--        if (valid) {-->
<!--          if (!this.form.validCode) {-->
<!--            this.$message.error("请填写验证码")-->
<!--            return-->
<!--          }-->
<!--          if(this.form.validCode.toLowerCase() !== this.validCode.toLowerCase()) {-->
<!--            this.$message.error("验证码错误")-->
<!--            return-->
<!--          }-->
<!--          request.post("/user/login", this.form).then(res => {-->
<!--            if (res.code === '0') {-->
<!--              this.$message({-->
<!--                type: "success",-->
<!--                message: "登录成功"-->
<!--              })-->
<!--              sessionStorage.setItem("user", JSON.stringify(res.data))  // 缓存用户信息-->

<!--              // 登录成功的时候更新当前路由-->
<!--              activeRouter()-->
<!--              this.$router.push("/")  //登录成功之后进行页面的跳转，跳转到主页-->

<!--            } else {-->
<!--              this.$message({-->
<!--                type: "error",-->
<!--                message: res.msg-->
<!--              })-->
<!--            }-->
<!--          })-->
<!--        }-->
<!--      })-->
<!--    }-->
<!--  }-->
<!--}-->
<!--</script>-->

<style scoped>
</style>
