<template>

  <div class="container" v-show="loading">
    <a id="top"></a>
    <div class="head" style="align-items: center; justify-content: center;display: flex; flex-direction: column; ">
      <div style="flex-direction: column;display: flex;align-items: center;justify-content: center;">
        <h1 style="color: white ;font-family: Playball, cursive ;font-size: 3rem"><span>{{ this.user.nickName }}</span></h1>
        <h2 style="color: white ;font-family: LongCang-Regular, cursive ;font-size: 1.5rem; margin-top: -20px">不想做选择</h2>
      </div>
    </div>
    <el-button class="custom-button" @click="goToHome()">HOME</el-button>
    <!-- 博客内容展示区域 -->
    <el-main class="main">
      <div v-show="blogs.length === 0" style="height: 300px;display: flex;justify-content: center">
        <div>
          <h2>您目前还没发现喜欢的博客哦~</h2><br>
          <div style="display: flex;align-items: center;justify-content: center">
            <el-button type="text" class="el-icon-house" @click="goToHome()">返回主页</el-button>
          </div>
        </div>
      </div>
      <div class="blogByUser" v-show="blogs.length > 0">
        <div v-for="blog in blogs" :key="blog.id" class="blog-item" style="width: 100%; height: 250px">
          <!-- 博客条目内容 -->
          <el-button type="text"
                     style="color: black; font-size: 33px;font-weight: normal; margin-top: 15px"
                     class="blog-title" @click="lookBlog(blog.id)">{{ blog.title }}
          </el-button>
          <div style="display: flex;">
            <div style="color: #999; font-size: 15px;"
            > 发布于{{ blog.gmtCreate }}</div>
            <div style="color: #999; font-size: 15px; margin-left: 10px;"
                 class="iconfont icon-chakan"> 点击量 ：{{ blog.clickCount }}</div>
            <div style="color: #999; font-size: 15px; margin-left: 10px;"
                 class="iconfont icon-pinglun1"> 评论 ：{{ blog.comment }}</div>
            <div style="color: #999; font-size: 15px; margin-left: 10px;"
                 class="iconfont icon-dianzan1"> 推荐 ：{{ blog.likeCount }}</div>
          </div>

          <div style="margin-top: 20px">
            <span style="color: #555; font-weight: bold;">摘要 : {{ getBlogSummary(blog.content) }}</span>
            <div style="position: absolute;">
              <el-button type="text" style="font-size: 16px;font-weight: 550; border-bottom: 2px solid #666;
            display: block; text-align: center;color: #555 !important;padding: 0; margin-top: 35px"
                         @click="lookBlog(blog.id)">阅读全文 »</el-button>
            </div>
          </div>

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
      user:"",
      loading: false,
      blogs:[] ,
    }
  },
  computed: {
    getBlogSummary() {
      return (content) => {
        // 去除内容中的HTML标签
        const tempDiv = document.createElement("div");
        tempDiv.innerHTML = content;
        // 去除内容中的HTML标签，并将多个连续空格替换为单个空格
        const summaryWithoutTags = tempDiv.textContent.replace(/\s+/g, " ").trim();
        // 如果内容长度小于等于30，则直接返回摘要
        if (summaryWithoutTags.length <= 100) {
          return summaryWithoutTags;
        }
        // 截取前30个字符作为摘要，并在末尾加上省略号
        return summaryWithoutTags.substring(0, 100) + "...";
      };
    },
  },
  methods: {
    goToHome() {
      this.$router.push('/blog/home');
    },
    lookBlog(id) {
      this.$router.push({path: '/blog/lookBLog', query: {id: id}});
    },
    queryLikeBlogByUser(){
      this.$axios.get("blog/userLikeBlogs").then(res => {
        if(res.data.code === 200){
          this.blogs = res.data.data;
          this.loading = true
        }
        else{
          this.$message.warning("网络异常")
        }
      })
    }
  },
  mounted() {
    this.user = JSON.parse(localStorage.getItem("user"))
    this.queryLikeBlogByUser()
  },

  created() {
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

.blog-item {
  width: 65%;
  border-bottom: 1px solid #ccc;
  padding-bottom: 10px;
  margin-bottom: 10px;
}

.blog-title {
  font-size: 36px;
  font-weight: bold;
  margin-bottom: 10px;
}

/* 添加阴影过渡效果 */
.main {
  background-color: white;
  width: auto;
  min-width: 65%;
  overflow: hidden; /* 当内容超过div宽度时，隐藏溢出部分 */
  max-width: 68%;
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
.head {
  width: 100%;
  height: 100vh; /* 100% 屏幕高度，让背景图片铺满整个屏幕 */
  background-size: cover; /* 缩放背景图片以覆盖整个容器 */
  background-image: url("../../assets/img/3.jpg");
  background-position: center center; /* 将背景图片居中显示 */
  margin: 0; /* 去掉默认边距 */
  padding: 0; /* 去掉默认填充 */
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