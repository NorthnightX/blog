<template>

  <div class="container" v-show="loading">
    <a id="top"></a>
    <div v-if="blogImage.length > 0"  class="headBlog" :style="{ alignItems : 'center', justifyContent: 'center',display: 'flex', flexDirection: 'column',
   backgroundImage: `url(${blogImage})`} ">
      <h1 style="color: white ;font-family: Playball, cursive ;font-size: 3rem"><span>{{ this.blog.bloggerName}}</span></h1>
      <h2 style="color: white ;font-family: LongCang-Regular, cursive ;font-size: 1.5rem; margin-top: -20px">不想做选择</h2>
      <div class="arrow" :class="{ 'arrow-up': isArrowUp }" @click="scrollToContent">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="48" height="48">
          <path d="M7 10l5 5 5-5z" />
          <path d="M0 0h24v24H0z" fill="none" />
        </svg>
      </div>
    </div>
    <div v-else class="headNoImage" style="align-items : center; justify-content: center;display: flex; flex-direction: column; ">
      <h1 style="color: white ;font-family: Playball, cursive ;font-size: 3rem"><span>{{ this.blog.bloggerName }}</span></h1>
      <h2 style="color: white ;font-family: LongCang-Regular, cursive ;font-size: 1.5rem; margin-top: -20px">不想做选择</h2>


      <div class="arrow" :class="{ 'arrow-up': isArrowUp }" @click="scrollToContent">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="48" height="48">
          <path d="M7 10l5 5 5-5z" />
          <path d="M0 0h24v24H0z" fill="none" />
        </svg>
      </div>
    </div>
    <el-button class="custom-button" @click="goToHome()">HOME</el-button>

    <!-- 博客内容展示区域 -->
    <el-main class="main">
      <div class="blog-content">
        <h1 class="blog-title">{{ blog.title }}</h1>
        <p class="blog-date">{{ blog.date }}</p>
        <div v-html="markedContent"></div>
      </div>
      <p style="text-align: center; font-size: 16px;font-weight: 700;color: #dddddd">__EOF__</p>
      <div class="user-section"
           style="background-image: linear-gradient(180deg,#fff,#f5f5fa);box-shadow: 4px 3px 0 rgb(37 44 97/10%), 0 1px 3px 0 rgb(93 100 148/13%); display: flex">
        <img :src="blog.bloggerImage">
        <div style="margin-left: 20px">
          <div style="margin-top: 10px">
            <strong style="color: #3a8ee6">本文作者</strong>：<span style="color: #3a8ee6"> {{
              blog.bloggerName
            }} </span>
          </div>
          <div style="margin-top: 10px">
            <strong style="color: #3a8ee6">关于博主</strong>： 评论和私信会在第一时间回复。或者直接私信我。
          </div>
          <div style="margin-top: 10px">
            <strong style="color: #3a8ee6">版权声明</strong>： 本博客所有文章除特别声明外，均采用<span
              style="color: #3a8ee6">BY-NC-SA </span>许可协议。转载请注明出处！
          </div>
          <div style="margin-top: 10px">
            <strong style="color: #3a8ee6">声援博主</strong>： 如果您觉得文章对您有帮助，可以点击文章右下角<span
              style="color: #3a8ee6">【推荐】</span>一下。
          </div>
        </div>
        <div style="width: 146px;">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 147.78 155.96">
            <path
                d="M10.5,99.81a1.9,1.9,0,0,0-.53-.09,1.66,1.66,0,0,0-1.64,1.65A1.64,1.64,0,0,0,10,103a1.57,1.57,0,0,0,.87-.25l26.76,26.82.45-1.08L11.52,101.91A1.65,1.65,0,0,0,10.5,99.81Zm-.13,2a.57.57,0,0,1-.8,0,.58.58,0,0,1-.17-.41.58.58,0,0,1,.57-.57h0a.57.57,0,0,1,.56.58A.55.55,0,0,1,10.37,101.77Z"
                style="fill:#c5c9e0"></path>
            <path
                d="M56.15,117.58H39.06l0-.09a1.65,1.65,0,0,0-1.36-1H37.5a1.65,1.65,0,1,0,1.56,2.19H55.7L92.92,156h41.44v-1.08h-41Zm-18.25.94a.56.56,0,0,1-.79,0,.58.58,0,0,1-.17-.41.57.57,0,0,1,.56-.57h0a.58.58,0,0,1,.57.58A.54.54,0,0,1,37.9,118.52Z"
                style="fill:#c5c9e0"></path>
            <path
                d="M23.52,50.32a1.65,1.65,0,0,0,1.55-1.11H55.28l48-48.13h31.06V0H102.85l-48,48.13H25.07a1.64,1.64,0,0,0-2.09-1,1.64,1.64,0,0,0,.54,3.2Zm0-2.21a.57.57,0,0,1,0,1.13.57.57,0,1,1,0-1.13Z"
                style="fill:#c5c9e0"></path>
            <polygon points="102.86 0 102.86 0 102.86 0 102.86 0" style="fill:#c5c9e0"></polygon>
            <path
                d="M107.72,12.14h26.64V11.07H107.27L57.4,61H3.09a1.66,1.66,0,0,0-1.45-.86H1.52A1.65,1.65,0,1,0,2.81,63a1.59,1.59,0,0,0,.45-.87H57.85ZM2.05,62.23a.57.57,0,0,1-.8,0,.58.58,0,0,1-.17-.41.57.57,0,0,1,.56-.57h.09a.57.57,0,0,1,.32,1Z"
                style="fill:#c5c9e0"></path>
            <path
                d="M134.36,43.22V42.14h-22.3l-9.62,9.63a1.64,1.64,0,0,0-2.19.77,1.61,1.61,0,0,0-.17.71,1.65,1.65,0,1,0,3.29,0,1.61,1.61,0,0,0-.16-.72l9.3-9.32Zm-32.64,10.6a.57.57,0,0,1,0-1.13.57.57,0,0,1,0,1.13Z"
                style="fill:#c5c9e0"></path>
            <path
                d="M147,52.3l-9,9H111.48a1.64,1.64,0,0,0-1.61-1.33h-.14a1.65,1.65,0,1,0,1.6,2.41h27.19l9.26-9.29L147,52.3Zm-37.15,9.85a.56.56,0,0,1-.56-.57h0a.56.56,0,0,1,.56-.56h0a.57.57,0,1,1,0,1.13Z"
                style="fill:#c5c9e0"></path>
            <path
                d="M66.79,75.35l11,11.06h56.53V85.33H78.27l-11-11.06H49.49L37.12,86.67a1.64,1.64,0,0,0-2.09,1,1.61,1.61,0,0,0-.09.54,1.65,1.65,0,0,0,3.29,0,1.68,1.68,0,0,0-.26-.89l12-12ZM36.58,88.79a.57.57,0,1,1,.57-.56A.57.57,0,0,1,36.58,88.79Z"
                style="fill:#c5c9e0"></path>
            <path
                d="M110.61,95.55,92.8,113.4a1.62,1.62,0,1,0,.77.76l17.49-17.53h23.31V95.55ZM92.49,115.28a.56.56,0,0,1-.8,0,.58.58,0,0,1-.17-.41.57.57,0,0,1,.57-.57h0a.58.58,0,0,1,.56.58A.55.55,0,0,1,92.49,115.28Z"
                style="fill:#c5c9e0"></path>
            <path
                d="M97.89,122.3H76.62L64.2,109.85a1.65,1.65,0,0,0-.77-2.2,1.77,1.77,0,0,0-.72-.17h-.14a1.65,1.65,0,0,0,.15,3.29,1.58,1.58,0,0,0,.71-.17l12.74,12.77H98.34l17.48-17.52h18.54v-1.08h-19ZM63.12,109.53a.56.56,0,0,1-.8,0,.58.58,0,0,1-.17-.41.57.57,0,0,1,1.14,0A.54.54,0,0,1,63.12,109.53Z"
                style="fill:#c5c9e0"></path>
          </svg>
        </div>
      </div>

      <div class="editor" style="margin-top: 50px">
        <div>
          发布评论
          <hr class="gray-hr"/>
        </div>
        <div style="margin-top: 10px">
          <mavon-editor v-model="commentForm.comment"
                        ref=md
                        @imgAdd="$imgAdd"></mavon-editor>
          <div style="margin-top: 10px">
            <el-button type="primary" style="color: white; background-color: steelblue" @click="submitComment()">发布</el-button>
            <el-button type="text">取消</el-button>
          </div>
        </div>
      </div>
      <div class="comment-section" style="height: auto">
        评论区
        <hr class="gray-hr"/>
        <div class="comment_main">
          <div v-for="(comment, index) in comments" :key="comment.id">
            <div class="comment-item">
              <div>
                <span style="font-weight: bold;color: cornflowerblue;">#{{index + 1}}楼</span>
                <span style="color: #888888; margin-left: 10px; font-size: 14px">{{comment.modifyTime}}</span>
              </div>
              <div style="margin-top: 15px; display: flex; align-items: center; justify-content: space-between; width: 100%;">
                <div style="display: flex; align-items: center;">
                  <div class="block"><el-avatar shape="square" :size="50" :src="comment.userImage"></el-avatar></div>
                  <span style="font-weight: bold;color: cornflowerblue;margin-left: 10px">{{comment.userName}}:</span>
                  <span style="margin-left: 10px">{{ comment.comment }}</span>
                </div>
                <div>
                  <el-button  type="text"  style="color: #3366cc;font-size: 10px"
                              v-show="user != null && (blog.bloggerId === user.id || comment.userId === user.id)"
                              @click="deleteComment(comment.id)">删除</el-button>
                </div>
              </div>
              <hr class="gray-hr" />
            </div>
          </div>
        </div>
      </div>
    </el-main>

    <div class="footer-content" style="height: 200px">
      <div  style=" background-size: 100%; width: 100%; justify-content: center;display: flex;align-items: center">
        <div>
          <p style="color: #666666; font-family: Playball,serif;font-size: 20px">This blog has running: {{ formattedCreationTime }} ღゝ◡╹)ノ♡</p>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import {marked} from 'marked';
import hljs from 'highlight.js';
import {MessageBox} from "element-ui";

export default {
  data() {
    return {
      loading:false,
      blogImage:"",
      deleteCommentForm:{
        commentId:'',
        blogId:''
      },
      isArrowUp: false,
      offset: 200,
      guideDetail: {
        content: '',
      },
      user:{},
      blog:{},
      rules: {
        content: [
          {required: true, message: '请输入内容', trigger: 'blur'}
        ]
      },
      comments:[],
      blogById: '',
      editBlogForm: {
        isLike: 1,
        blogId:''
      },
      commentForm: {
        comment:'',
        blogId:''
      },
      intervalId: null,
      formattedCreationTime: null,
    }
  },
  computed: {
    url() {
      return url
    },
    markedContent() {
      marked.setOptions({
        highlight: (code, lang) => {
          if (lang && hljs.getLanguage(lang)) {
            return hljs.highlight(lang, code).value;
          }
          return hljs.highlightAuto(code).value;
        },
      });
      return marked(this.blog.content);
    },
    formattedCreationTime() {
      return this.formatDate(this.blog.gmtCreate);
    },
  },
  methods: {
    deleteComment(id){
      MessageBox.confirm('确定要删除吗？', '确认删除', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.deleteCommentForm.commentId = id
        this.deleteCommentForm.blogId = this.blog.id
        this.$axios.put(("/comment/deleteComment"), this.deleteCommentForm).then(res => {
          if(res.data.code === 200){
            this.$message.success(res.data.data);
            setTimeout(() => {
              this.queryComment(this.blog.id)
            }, 500);
          }
          else{
            this.$message.warning(res.data.message);
          }
        })
      })
    },
    goToHome() {
      this.$router.push('/blog/home');
    },
    submitComment(){
      if(localStorage.getItem("token") == null){
        this.$router.push('/');
      }
      else {
        this.commentForm.blogId = this.blog.id
        this.$axios.post("comment/addComment", this.commentForm).then(res => {
          if(res.data.code === 200){
            this.commentForm.comment = ""
            this.$message.success("评论成功")
            setTimeout(() => {
              this.queryComment(this.blogById)
            }, 1000);
          }
          else {
            this.$message.warning("网络异常")
          }
        })
      }
    },
    $imgAdd(pos, $file) {
      var formdata = new FormData();
      formdata.append('image', $file);
      this.$axios.post("upload/uploadBlogImage", formdata).then(res => {
        if (res.status === 200) {
          var url = res.data.data;
          this.$refs.md.$img2Url(pos, url)
        }
        else {
          this.$message("网络异常")
        }
      })
    },
    handleScroll() {
      const contentSection = document.querySelector('.blog-content');
      if (contentSection) {
        const contentRect = contentSection.getBoundingClientRect();
        const contentMiddle = contentRect.top + contentRect.height / 2;
        this.isArrowUp = window.scrollY >= contentMiddle - this.offset;
      }
    },
    scrollToContent() {
      const contentSection = document.querySelector('.blog-content');
      if (contentSection) {
        contentSection.scrollIntoView({
          behavior: 'smooth',
          block: 'start',
        });
      }
    },
    // 展示时间格式
    formatDate(dateString) {
      const creationTime = new Date(dateString);
      const currentTime = new Date();
      const timeDifference = currentTime - creationTime;
      const seconds = Math.floor(timeDifference / 1000);
      const minutes = Math.floor(seconds / 60);
      const hours = Math.floor(minutes / 60);
      const days = Math.floor(hours / 24);
      this.formattedCreationTime = `${days} d ${hours % 24} h ${minutes % 60} m ${seconds % 60} s`;
    },
    queryBlogMsg(id){
      this.$axios.get("blog/getBlogById/" + id).then(res => {
        if(res.data.code === 200){
          this.blog = res.data.data
          this.blogImage = this.blog.image.length > 0 ? this.blog.image : "";
          if(localStorage.getItem("token") != null){
            this.user = JSON.parse(localStorage.getItem("user"))
          }
        } else {
          this.$message.warning("网络异常")
        }
      })
    },
    queryComment(id){
      this.$axios.get("/comment/getCommentByBlog/" + id).then(res => {
        if(res.data.code === 200){
          this.comments = res.data.data
        }
        else{
          this.$message.warning("网络异常，评论未正常加载")
        }
      })
    }
  },
  mounted() {
    this.blogById = this.$route.query.id || "";
    this.queryBlogMsg(this.blogById)
    this.formatDate(this.blog.gmtCreate);
    this.intervalId = setInterval(() => this.formatDate(this.blog.gmtCreate), 1000);
    window.addEventListener('scroll', this.handleScroll);
    this.$nextTick(() => {
      this.queryComment(this.blogById);
      setTimeout(() => {
        window.scrollTo(0, 0);
        this.loading = true
      }, 500);
    })
  },

  created() {
  },

  beforeDestroy() {
    clearInterval(this.intervalId);
    window.removeEventListener('scroll', this.handleScroll);
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

.blog-title {
  font-size: 36px;
  font-weight: bold;
  margin-bottom: 10px;
}

.blog-date {
  font-size: 14px;
  color: #888;
}

.user-section {
  height: 150px;
  width: 100%;
  margin-top: 10px;
  background-color: white;
  border-radius: 10px; /* Add rounded corners */
  transition: background-color 0.3s ease-in-out; /* Add transition effect */
}

.gray-hr {
  border: none;
  border-top: 1px solid #ccc;
  margin: 0;
  margin-top: 10px;
  width: 100%;
}

.comment-section {
  margin-top: 40px;
  height: 100px;
  width: 100%;
  background-color: white;
  border-radius: 10px; /* Add rounded corners */
  transition: background-color 0.3s ease-in-out; /* Add transition effect */
}

.blog-content {
  padding: 20px;
  line-height: 1.6;
  text-align: justify;
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
.headBlog {
  width: 100%;
  height: 40vh; /* 100% 屏幕高度，让背景图片铺满整个屏幕 */
  background-size: cover; /* 缩放背景图片以覆盖整个容器 */
  background-position: center center; /* 将背景图片居中显示 */
  margin: 0; /* 去掉默认边距 */
  padding: 0; /* 去掉默认填充 */
}
.headNoImage{
  background-image: url("../../assets/img/3.jpg");
  background-position: center;
  width: 100%;
  height: 40vh; /* 100% 屏幕高度，让背景图片铺满整个屏幕 */
  background-size: cover; /* 缩放背景图片以覆盖整个容器 */
  margin: 0; /* 去掉默认边距 */
  padding: 0; /* 去掉默认填充 */
}

.arrow {
  position: fixed;
  bottom: 20px;
  right: 20px;
  cursor: pointer;
  z-index: 999;
  transition: transform 0.2s;
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