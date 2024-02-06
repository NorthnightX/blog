<template>
  <div class="blog-app" v-if="loading">

    <!-- 主要内容区域 -->
    <main class="mainSearch">
      <!-- 搜索栏 -->
      <div class="search-bar" style=" margin-top: -2px">
        <div class="search-bar-container" style="margin-top: -15px">
          <img src="../../assets/img/logo.svg" alt="logo" style="height: 36px;display: block">
          <el-button style="margin-left: 90px;font-size: 16px" type="text" @click="goToHome()">首页</el-button>
          <el-button style="margin-left: 30px;font-size: 16px" type="text">新闻</el-button>
          <el-button style="margin-left: 30px;font-size: 16px" type="text">博文</el-button>
          <el-button style="margin-left: 30px;font-size: 16px" type="text">会员</el-button>
          <el-button style="margin-left: 30px;font-size: 16px" type="text">直播</el-button>
          <el-button style="margin-left: 30px;font-size: 16px" type="text">发现</el-button>
        </div>
        <div style="margin-left: 500px; padding-top: 25px">
          <el-form :inline="true" :model="formInline" class="user-search">
            <el-form-item>
              <el-input size="small" v-model="formInline.keyword" placeholder="代码改变世界">
                <!-- 在搜索栏中添加一个图标按钮 -->
                <el-button slot="append" icon="el-icon-search" size="small" circle
                           @click="search()"></el-button>
              </el-input>
            </el-form-item>
          </el-form>
        </div>
        <div style="; display: flex; align-items: center;">
          <a type="text" style="margin-left: 10px;margin-right: 20px" class="iconfont icon-bianji">
          </a>
          <a type="text" style="margin-left: 10px ;margin-right: 20px" class="iconfont icon-bokeyuan">
          </a>
          <a type="text" style="margin-left: 10px; margin-right: 20px" class="iconfont icon-xiaoxi">
          </a>
          <div style="margin-bottom: 6px">
            <el-avatar :src=userImage></el-avatar>
          </div>
        </div>
      </div>
      <!--      主要区域-->
      <div class="main-body" style="margin-top: -30px">
        <!--        中间博客区域-->
        <div style="margin-left: 30px; width: 100%">
          <!-- 博客列表 -->
          <div v-if="blogs.length === 0" style="margin-top: 20px; margin-left: 10px">
            <img src="../../assets/img/img.png" alt="查询未命中"><br>
            <span>抱歉！没有找到您搜索的相关内容。</span><br>
            <div style="padding-top: 5px">
              <span>建议您：</span><br>
              <br>
              <span style="margin-left: 5%">检查输入的关键词是否正确；</span><br>
              <span style="margin-left: 5%">向园子的服务人员<span
                  style="color: #3a8ee6;text-decoration: underline">反馈问题</span>；</span><br>
              <span style="margin-left: 5%">去<span style="color: #3a8ee6;text-decoration: underline">博问</span>寻求园友的的帮助。</span>
            </div>
          </div>
          <div class="blog-list" v-else>
            <!-- 使用循环显示博客列表 -->
            <div v-for="blog in blogs" :key="blog.id" class="blog-item" style="width: 100%">
              <!-- 博客条目内容 -->
              <el-button
                  type="text"
                  style="color: #3366cc; font-size: 13px; text-decoration: underline; font-weight: bold"
                  class="blog-title"
                  @click="lookBlog(blog.id)"
                  v-html="getBlogTitleWithEm(blog.title)"
              ></el-button>
              <div style="display: flex">
                <div>
                  <el-avatar shape="square" :size="50" :src=blog.bloggerImage></el-avatar>
                </div>
                <p style="font-size: 13px" v-html="getBlogSummary(blog.content)"></p>
              </div>
              <!--              每条博客下方的基本数据-->
              <div style="display: flex; font-size: 13px">
                <el-button type="text" style="text-decoration: underline; color: #3a8ee6; margin-left: 10px">
                  {{ blog.bloggerName }}
                </el-button>
                <span style="margin-left: 10px;margin-top: 12px">{{ blog.gmtModified }}</span>
                <el-button type="text" style="margin-left: 10px;" class="iconfont icon-dianzan1"
                           v-show="userLike.includes(blog.id.toString())"
                           @click="likeBlog(blog.id)">{{ blog.likeCount }}
                </el-button>
                <el-button type="text" style="margin-left: 10px;color: #888888" class="iconfont icon-dianzan1"
                           v-show="!userLike.includes(blog.id.toString())"
                           @click="likeBlog(blog.id)">{{ blog.likeCount }}
                </el-button>
                <el-button type="text" style="margin-left: 10px" class="iconfont icon-pinglun1">{{
                    blog.comment
                  }}
                </el-button>
                <el-button type="text" style="margin-left: 10px" class="iconfont icon-chakan">{{
                    blog.clickCount
                  }}
                </el-button>
              </div>
            </div>
          </div>

          <!-- 分页 -->
          <div class="pagination" v-show="showPagination">
            <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                :current-page="pageNum"
                :page-sizes="[10, 15, 20, 25]"
                :page-size="pageSize"
                layout="total, sizes, prev, pager, next, jumper"
                :total="total"
            ></el-pagination>
          </div>
        </div>

        <!--        左边栏-->
        <div style="width: 25%; background-color: #F4F3F2">
          <div style="height: auto;margin-top: 20px;margin-left: 15px">
            48小时阅读排行：
            <div v-for="(blog, index) in readNumMaxInTwoDaysBlogs" :key="blog.id">
              <el-button type="text" style="color: black; font-weight: normal;font-size: 10px" @click="lookBlog(blog.id)"> {{index + 1}} &nbsp; {{getBlogTitle(blog.title)}}</el-button>

            </div>
          </div>
        </div>
      </div>

      <!-- 页脚 -->
      <div class="footer" style="background-color: gainsboro;display: flex;align-items: center;justify-content: center">
        <div class="footer-content">
          <p>© 2023 Your Blog. All rights reserved.</p>
          <ul class="footer-links">
            <a href="#">关于我们</a>
            <a href="#" style="margin-left: 10px">隐私政策</a>
            <a href="#" style="margin-left: 10px">使用条款</a>
          </ul>
        </div>
      </div>
    </main>
  </div>
</template>

<script>
export default {
  name: "BlogApp",
  data() {
    return {
      readNumMaxInTwoDaysBlogs: [],
      likeButtonDisabled: false,
      userLike: [],
      loading: false,
      showPagination: true,
      userImage: '',
      formInline: {
        keyword: ""
      },
      editBlogForm: {
        isLike: 1,
        blogId: ''
      },
      blogs: [],
      pageNum: 1, // 当前页码
      pageSize: 10, // 每页显示的博客数量
      total: 0, // 博客总数
    };
  },
  computed: {
    getBlogTitle() {
      return (content) => {
        if (content.length <= 16) {
          return content;
        }
        return content.substring(0, 16) + "...";
      };
    },
    getBlogTitleWithEm() {
      return (title) => {
        // 将被<em>标签包裹的部分用<span>标签包裹，并设置为红色
        return title.replace(/<em>(.*?)<\/em>/g, '<span style="color: red;">$1</span>');
      };
    },
    // 计算属性用于处理blog.content并生成摘要
    getBlogSummary() {
      return (content) => {
        // Function to get text content from a node and its descendants
        function getTextContent(node) {
          if (node.nodeType === Node.TEXT_NODE) {
            return node.textContent;
          } else if (node.nodeType === Node.ELEMENT_NODE) {
            let text = "";
            for (const childNode of node.childNodes) {
              if (childNode.nodeName === "EM") {
                // Handle <em> tags separately to preserve them
                text += `<em>${getTextContent(childNode)}</em>`;
              } else {
                text += getTextContent(childNode);
              }
            }
            return text;
          } else {
            return "";
          }
        }

        const tempDiv = document.createElement("div");
        tempDiv.innerHTML = content;

        const summaryText = getTextContent(tempDiv).trim();
        if (summaryText.length <= 100) {
          return summaryText;
        }
        return summaryText.substring(0, 100) + "...";
      };
    },

  },
  methods: {
    readNumMaxInTwoDays(){
      this.$axios.get("blog/readNumMaxInTwoDays").then(res => {
        if(res.data.code === 200){
          this.readNumMaxInTwoDaysBlogs = res.data.data
        }
      })
    },
    lookBlog(id) {
      this.$router.push({path: '/blog/lookBLog', query: {id: id}});
    },
    goToHome() {
      this.$router.push('/blog/home');
    },
    search() {
      if (this.formInline.keyword != null && this.formInline.keyword.length > 0) {
        this.queryByKeyword()
      }
    },
    likeBlog(id) {
      if(localStorage.getItem("token") == null){
        return;
      }
      if (this.likeButtonDisabled) {
        this.$message.warning("您点的太快了")
        return; // 如果按钮已禁用，不执行操作
      }
      this.likeButtonDisabled = true; // 禁用按钮
      this.editBlogForm.blogId = id
      this.$axios.post("isLike/likeBlog", this.editBlogForm).then(res => {
        if (res.data.code === 200) {
          this.$message.success(res.data.data);
          this.pageNum = 1;
          this.queryUserLikeBlog()
          const blogIndex = this.blogs.findIndex(blog => blog.id === id);
          if (blogIndex !== -1) {
            if (res.data.data === "点赞成功") {
              this.blogs[blogIndex].likeCount++; // 增加点赞数
            } else {
              this.blogs[blogIndex].likeCount--; // 减少点赞数
            }
          }
          setTimeout(() => {
            this.pageNum = 1;
            this.queryByKeyword();
            this.likeButtonDisabled = false;
          }, 1000);
        } else {
          this.$message.warning("网络异常")
        }
      })
    },
    queryUserLikeBlog() {
      if(localStorage.getItem("token") == null){
        return;
      }
      this.$axios.get("isLike/queryLikeByUser").then(res => {
        if (res.data.code === 200) {
          this.userLike = res.data.data
        } else {
          this.$message.warning("网络异常")
        }
      })
    },
    // 处理每页显示数量的变化
    handleSizeChange(val) {
      this.pageSize = val
      this.queryByKeyword();
    },
    handleCurrentChange(val) {
      this.pageNum = val
      this.queryByKeyword()
    },
    setImage(){
      if(localStorage.getItem("token") == null){
        this.userImage = ""
      }
      else this.userImage = JSON.parse(localStorage.getItem("user")).image
    },
    queryByKeyword() {
      this.$axios.get("blog/queryByKeyword", {
        params: {
          keyword: this.formInline.keyword,
          pageNum: this.pageNum,
          pageSize: this.pageSize
        }
      }).then(res => {
        if (res.data.code === 200) {
          this.blogs = res.data.data.records
          this.loading = true
          if (this.blogs.length === 0) {
            this.showPagination = false
          } else {
            this.showPagination = true
          }
          this.total = res.data.data.total
        } else {
          this.$message.warning(res.data.message)
        }
      })
    },
  },
  created() {
    // 当组件创建时，调用获取博客列表的函数
    this.formInline.keyword = this.$route.query.keyword || ''; // 使用默认值为空字符串
    this.setImage()
    this.queryByKeyword();
    this.queryUserLikeBlog()
    this.readNumMaxInTwoDays()
  },
};
</script>

<style scoped>
em {
  color: red; /* 设置<em>标签中的文本为红色 */
}

.search-bar {
  display: flex;
  justify-content: space-between;
  margin: 15px;
}

.search-bar-container {
  display: flex;
  align-items: center;
}

.blog-item {
  width: 70%;
  border-bottom: 1px solid #ccc;
  padding-bottom: 10px;
  margin-bottom: 10px;
}

.main-body {
  display: flex;
}
</style>
