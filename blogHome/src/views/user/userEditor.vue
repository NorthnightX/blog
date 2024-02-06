<template>
  <el-container style="height: 100%">
    <el-header style="background-color: black;display: flex;align-items: center;justify-content: space-between"
               class="fixed-header">
      <div style="display: flex;margin-left: 10px">
        <img :src="require('@/assets/img/adminlogo.png')" width="100px" @click="toHome()">
        <div style="width: 1px;height: 30px;margin: 0 16px;background-color: white"></div>
        <span style="color: white; padding-top: 5px">账户中心</span>
      </div>
      <div>
        <el-avatar :src="userImage"></el-avatar>
      </div>
    </el-header>
    <el-container>
      <el-aside width="250px" style="flex-direction: column; align-items: center;background-color: whitesmoke"
                class="fixed-aside">
        <div class="sidebar-item" style="width: 100%;color: #888888;height: 8%;margin-top: -3px">账户设置</div>
        <div class="sidebar-item" style="width: 100%;color: #888888;height: 8%">个人资料</div>
        <div class="sidebar-item" style="width: 100%;color: #888888;height: 8%">屏蔽设置</div>
        <div class="sidebar-item" style="width: 100%;color: #888888;height: 8%">博客设置</div>
      </el-aside>
      <div style="width: 100%;margin-left: 15%;margin-top: 3%">
        <el-main>
          <div style="flex-direction: column;justify-content: left;align-items: center">
            <div>
              <div style="display: flex;margin-left: 20px;margin-top: 10px">
                <div style="width: 7px;height: 20px;background-color: cornflowerblue"></div>
                <div>&nbsp;&nbsp;&nbsp;账号和安全</div>
              </div>
            </div>
            <div class="wrapper" style="height: auto; margin-top: 45px;margin-left: 45px">
              <div style="width: 70%;display: flex;justify-content: space-between">
                <label style="  color: dimgrey;font-size: 14px;">头像</label>
                <div style="margin-top: -10px;width: 100px;display: flex">
                  <div>
                    <el-avatar shape="square" :src="userImage" :size="50" @click.native="openFileInput"></el-avatar>
                    <input type="file" ref="fileInput" style="display: none" @change="handleFileChange">
                  </div>
                </div>
              </div>
              <div style="width: 70%;height: 0.5px;background-color: gainsboro;margin-top: 10px"></div>
              <form-input label="登录用户名" v-model="formData.name">
                <template v-slot:buttons>
                  <el-button @click="handleButton1" type="primary">确定</el-button>
                  <el-button @click="handleButton2">取消</el-button>
                </template>
              </form-input>
              <form-input label="密码" v-model="formData.password" type="password">
                <template v-slot:buttons>
                  <el-button @click="handleButton1" type="primary">确定</el-button>
                  <el-button @click="handleButton2">取消</el-button>
                </template>
              </form-input>
              <form-input label="显示昵称" v-model="formData.nickName">
                <template v-slot:buttons>
                  <el-button @click="handleButton1" type="primary">确定</el-button>
                  <el-button @click="handleButton2">取消</el-button>
                </template>
              </form-input>
              <form-input label="邮箱" v-model="formData.email">
                <template v-slot:buttons>
                  <el-button @click="handleButton1" type="primary">确定</el-button>
                  <el-button @click="handleButton2">取消</el-button>
                </template>
              </form-input>
              <form-input label="手机号" v-model="formData.phone">
                <template v-slot:buttons>
                  <el-button @click="handleButton1" type="primary">确定</el-button>
                  <el-button @click="handleButton2">取消</el-button>
                </template>
              </form-input>
            </div>
          </div>
        </el-main>
      </div>
    </el-container>
  </el-container>
</template>

<script>
import FormInput from '../FormInput.vue';

export default {
  components: {
    FormInput
  },
  data() {
    return {
      userMsg: {},
      showButtons: false,
      userImage: "",
      formData: {
        field:"",
        image: '',
        name: '',
        password: "",
        phone: '',
        nickName: '',
        email: '',
      }
    };
  },
  methods: {
    toHome(){
      this.$router.push('/blog/home');
    },
    openFileInput() {
      this.$refs.fileInput.click();
    },
    handleFileChange(event) {
      const file = event.target.files[0];
      if (file) {
        const formdata = new FormData();
        formdata.append('image', file);
        this.$axios.post('upload/uploadBlogImage', formdata).then(res => {
          if (res.data.code === 200) {
            var url = res.data.data;
            this.userImage = url;
            this.formData.image = url;
            this.formData.field="image"
            this.updateUser()
          } else {
            this.$message('网络异常');
          }
        });
      }
    },
    updateUser(){
      if(localStorage.getItem("token") == null){
        this.$message.warning("请先登录")
        return;
      }
      this.$axios.put("/user/update", this.formData).then(res => {
        if(res.data.code === 200){
          this.queryLoginUser()
          this.formData.field = ""
        }
        else{
          this.$message.warning("网络异常")
        }
      })
    },
    queryLoginUser(){
      this.$axios.get("/user/getLoginUser").then(res => {
        if(res.data.code === 200){
          localStorage.setItem("user", JSON.stringify(res.data.data))
        }
        else{
          this.$message.warning("网络异常")
        }
      })
    },
    showBorder() {
      this.showButtons = true;
    },
    hideBorder() {
      this.showButtons = false;
    },
    handleButton1() {
      // 处理按钮1的点击事件
    },
    handleButton2() {
      // 处理按钮2的点击事件
    },
    getAvatar() {
      let user = JSON.parse(localStorage.getItem("user"))
      this.formData = {...user}
      this.userImage = user.image
    }
  },
  created() {
    this.queryLoginUser()
    this.getAvatar();


  }
};
</script>

<style scoped>

.sidebar-item {
  color: #888888;
  height: 6%;
  margin-top: 20px;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
  margin-bottom: -20px;
}

.sidebar-item:hover {
  background-color: #ccc;
  color: #333;
}

.inputDeep >>> .el-input__inner {
  width: 70%;
  border-radius: 0;
  border-top-width: 0;
  border-left-width: 0;
  border-right-width: 0;
  border-bottom-width: 1px;
}

.wrapper {
  position: relative;
}
/* Fixed Header */
.fixed-header {
  position: fixed;
  width: 100%;
  top: 0;
  left: 0;
  z-index: 100;
}

/* Fixed Aside */
.fixed-aside {
  position: fixed;
  width: 250px;
  height: 100%;
  top: 61px;
  left: 0;
  z-index: 90;
}

</style>
