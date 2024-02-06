<template>

  <div class="container" v-show="loading">
    <a id="top"></a>
    <div class="headMsg" style="align-items: center; justify-content: center;display: flex; flex-direction: column; ">
      <h1 style="color: white ;font-family: Playball, cursive ;font-size: 3rem"><span>{{ this.user.nickName }}</span></h1>
      <h2 style="color: white ;font-family: LongCang-Regular, cursive ;font-size: 1.5rem; margin-top: -20px">不想做选择</h2>
    </div>

    <el-button class="custom-button" @click="goToHome()">HOME</el-button>
    <!-- 消息展示区域 -->
    <el-main class="msgHeader">
      <div style="display: flex;justify-content: space-between;align-items: center">
        <div>
          <span style="font-size: 15px; color: #888888">回复我的</span>
        </div>
      </div>
    </el-main>
    <el-main class="mainMsg">
      <div v-for="(message,index) in commentMessage">
        <div class="comment-item" style="margin-top: 10px" >
          <div>
            <span style="font-weight: bold;color: cornflowerblue;margin-left: 10px">{{message.commentUserName}}</span>
            <span style="color: #888888; margin-left: 10px; font-size: 14px">回复了我的文章：</span>
            <span style="color: #888888; margin-left: 10px; font-size: 14px">{{ message.commentBlogTitle }}</span>
          </div>
          <div style="margin-top: 15px; display: flex; align-items: center; justify-content: space-between; width: 100%;">
            <div style="display: flex; align-items: center;width: 100%">
              <div class="block"><el-avatar shape="square" :size="50" :src="message.commentUserImage"></el-avatar></div>
              <div style="display: flex;justify-content: space-between; margin-left: 10px;width: 100%">
                <div style="flex-direction: column;display: flex">
                  <span style="margin-left: 10px">{{ message.commentContent }}</span>
                  <span style="color: #888888; margin-left: 10px; font-size: 12px;">{{message.commentTime}}</span>
                </div>
                <div>
                  <el-button  type="text"  style="color: #3366cc;font-size: 10px"
                              @click="deleteMessage(message.commentId)">删除</el-button>
                </div>
              </div>
            </div>
          </div>
          <hr class="gray-hr" />
        </div>
      </div>

    </el-main>

    <div class="footer-content" style="height: 50px">
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      user: "",
      loading: true,
      commentMessage: [],
      delIds: []
    }
  },
  computed: {

  },
  methods: {
    goToHome() {
      this.$router.push('/blog/home');
    },
    deleteMessage(id){
      this.$axios.delete("/comment/delMsg", {params : {id : id}}).then(res => {
        if(res.data.code === 200){
          this.$message.success("删除成功")
          this.getUserMessage();
        }
        else{
          this.$message.warning("网络异常")
        }
      })
    },
    getUserMessage(){
      this.$axios.get("/comment/getCommentMsg").then(res => {
        if(res.data.code === 200){
          this.commentMessage = res.data.data
        }
        else {
          this.$message.warning("网络异常")
        }
      })
    }
  },
  mounted() {
    this.user = JSON.parse(localStorage.getItem("user"))
  },

  created() {
    this.getUserMessage()
  },

  beforeDestroy() {
  },
};
</script>

<style>
.custom-button {
  position: absolute;
  top: 0;
  left: 0;
  margin: 20px 25px;
  padding: 5px 10px;
  background-color: transparent;
  color: white;
  width: 100px;
  height: 40px;
  border-radius: 4px;
  cursor: pointer;
  overflow: hidden; /* 隐藏伪元素超出的部分 */
}

.custom-button::before {
  content: "";
  position: absolute;
  top: -1px; /* 负值表示向内偏移，实现更细的边框 */
  left: -1px;
  right: -1px;
  bottom: -1px;
  border: 0.5px solid white; /* 更细的边框 */
  border-radius: 4px; /* 与按钮相同的圆角 */
}
.custom-button:hover {
  background-color: transparent; /* 鼠标悬停时背景透明 */
}

.custom-button:hover::before {
  background-color: transparent;
}
/* 自定义样式 */
.container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: flex-start;

  margin: 0 auto;
  max-width: 100%;
//padding: 20px;
  height: auto; /* 修改这行样式 */
  overflow: auto; /* 添加这行样式 */
  border-width: 10px;
}

/* 添加阴影过渡效果 */
.mainMsg {
  background-color: white;
  width: auto;
  min-width: 65%;
  overflow: hidden; /* 当内容超过div宽度时，隐藏溢出部分 */
  max-width: 68%;
  margin-top: 10px;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
}

/* 添加过渡效果 */
.blog-content > * {
  transition: opacity 0.3s ease-in-out;
}

/* 隐藏浏览器默认的滚动条样式 */
body::-webkit-scrollbar {
  width: 0.2rem; /* 设置滚动条宽度 */
}

/* 设置滚动条轨道的背景色 */
body::-webkit-scrollbar-track {
  background-color: #f1f1f1;
}

/* 设置滚动条滑块的背景色 */
body::-webkit-scrollbar-thumb {
  background-color: #888;
}

/* 当滚动条处于hover状态时，设置滚动条滑块的背景色 */
body::-webkit-scrollbar-thumb:hover {
  background-color: #555;
}

.footer-content {
  width: 100%;
  align-items: center;
  display: flex;
  justify-content: center;
  margin: 0 auto;
}

.footer p {
  margin: 10px 0;
  color: #666;
}

.footer-links li {
  display: inline-block;
  margin-right: 15px;
}

.footer-links li:last-child {
  margin-right: 0;
}

.footer-links a {
  color: #666;
  text-decoration: none;
}

.footer-links a:hover {
  color: #3a8ee6;
}
.headMsg {
  width: 100%;
  height: 40vh; /* 100% 屏幕高度，让背景图片铺满整个屏幕 */
  background-size: cover; /* 缩放背景图片以覆盖整个容器 */
  background-image: url("../../assets/img/3.jpg");
  background-position: center center; /* 将背景图片居中显示 */
  margin: 0; /* 去掉默认边距 */
  padding: 0; /* 去掉默认填充 */
}
.msgHeader{
  margin-top: 10px;
  background-color: white;
  width: auto;
  min-width: 65%;
  overflow: hidden; /* 当内容超过div宽度时，隐藏溢出部分 */
  max-width: 68%;
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
}

.arrow svg {
  width: 48px;
  height: 48px;
  fill: steelblue;
}

.arrow.arrow-up svg {
  transform: rotate(180deg);
}
</style>