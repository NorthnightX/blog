<template>
  <el-container>
    <div class="blog-app" v-if="loading" style="width: 100%">
      <!-- 主要内容区域 -->
      <main class="mainHome" style="width: 100%;">
        <!-- 搜索栏 -->
        <div class="search-bar" style=" margin-top: -2px">
          <div class="search-bar-container" style="margin-top: -15px">
            <img src="../../assets/img/logo.svg" alt="logo" style="height: 36px;display: block">
            <el-button style="margin-left: 90px;font-size: 16px" type="text">首页</el-button>
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
                             @click="searchBlog()"></el-button>
                </el-input>
              </el-form-item>
            </el-form>
          </div>
          <div style="; display: flex; align-items: center;">
            <el-button type="text" style="margin-left: 10px;margin-right: 20px" class="iconfont icon-bianji"
                       @click="editorBlog()">
            </el-button>
            <el-button type="text" @click.native="findMyBLog()" style="margin-left: 10px ;margin-right: 20px"
                       class="iconfont icon-bokeyuan">
            </el-button>
            <el-button type="text" @click.native="myMessage()" style="margin-left: 10px; margin-right: 20px" class="iconfont icon-xiaoxi">
            </el-button>
            <div style="margin-bottom: 6px">
              <el-dropdown trigger="hover">
                <el-avatar :src="userImage"></el-avatar>
                <el-dropdown-menu slot="dropdown">
                  <el-dropdown-item @click.native="findMyBLog()">我的博客</el-dropdown-item>
                  <el-dropdown-item>我的园子</el-dropdown-item>
                  <el-dropdown-item @click.native="countSetUp()">账号设置</el-dropdown-item>
                  <el-dropdown-item>简洁模式</el-dropdown-item>
                  <el-dropdown-item @click.native="logout">退出登录</el-dropdown-item>
                </el-dropdown-menu>
              </el-dropdown>
            </div>
          </div>
        </div>
        <!--      主要区域-->
        <div class="main-body" style="margin-top: -30px">
          <!--        右边栏-->
          <div style="width: 15%; background-color: #fcfcfc">
            <div style="display: flex; flex-direction: column; align-items: center; justify-content: center">
              <el-button type="text" style="color: black;margin-left: 12px" class="iconfont icon-fenlei">&nbsp 分类
              </el-button>
              <el-button type="text" style="color: black" class="iconfont icon-dingyuehao">&nbsp 订阅</el-button>
              <el-button type="text" style="color: black" class="iconfont icon-guanzhu">&nbsp 关注</el-button>
              <el-button type="text" style="color: black" class="iconfont icon-dianzan" @click="userLikeBlogs()">&nbsp
                点赞
              </el-button>
              <el-button type="text" style="color: black" class="iconfont icon-pinglun">&nbsp 评论</el-button>
              <el-button type="text" style="color: black" class="iconfont icon-gengduo">&nbsp 更多</el-button>
              <el-button type="text" style="color: black" class="iconfont icon-wentifankui">&nbsp 反馈</el-button>
            </div>
          </div>
          <!--        中间博客区域-->
          <div style="width: 65%">
            <!-- 博客列表 -->
            <div class="blog-list">
              <!-- 使用循环显示博客列表 -->
              <div v-for="blog in blogs" :key="blog.id" class="blog-item" style="width: 100%">
                <!-- 博客条目内容 -->
                <el-button type="text"
                           style="color: #3366cc; font-size: 13px; text-decoration: underline; font-weight: bold"
                           class="blog-title" @click="lookBlog(blog.id)">{{ blog.title }}
                </el-button>
                <div style="display: flex">
                  <div>
                    <el-avatar shape="square" :size="50" :src=blog.bloggerImage></el-avatar>
                  </div>
                  <p style="font-size: 11px">{{ getBlogSummary(blog.content) }}</p>
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
                  <el-button type="text" style="margin-left: 10px;color: #888888" class="iconfont icon-pinglun1">{{
                      blog.comment
                    }}
                  </el-button>
                  <el-button type="text" style="margin-left: 10px;color: #888888" class="iconfont icon-chakan">{{
                      blog.clickCount
                    }}
                  </el-button>
                </div>
              </div>
            </div>

            <!-- 分页 -->
            <div class="pagination">
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
          <div style="width: 20%; background-color:#fcfcfc">
            <div style="height: auto;margin-top: 20px;margin-left: 15px">
              48小时阅读排行：
              <div v-for="(blog, index) in readNumMaxInTwoDaysBlogs" :key="blog.id">
                <el-button type="text" style="color: black; font-weight: normal;font-size: 10px"
                           @click="lookBlog(blog.id)"> {{ index + 1 }} &nbsp; {{ getBlogTitle(blog.title) }}
                </el-button>

              </div>
            </div>
            <div style="margin-top: 10px">
              <span style="font-weight: bold;margin-left: 10px;
              font-family: LongCang-Regular, cursive;">今日活跃用户：{{ this.loginCount }}</span>
            </div>
          </div>
        </div>

        <!-- 页脚 -->
        <div class="footer"
             style="background-color: gainsboro;display: flex;align-items: center;justify-content: center">
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
  </el-container>
</template>

<script>
import {MessageBox} from "element-ui";

export default {
  name: "BlogApp",
  data() {
    return {
      readNumMaxInTwoDaysBlogs: [],
      likeButtonDisabled: false,
      loading: false,
      loginCount: '',
      userImage: '',
      formInline: {
        keyword: ""
      },
      editBlogForm: {
        isLike: 1,
        blogId: ''
      },
      userLike: [],
      blogs: [],
      pageNum: 1, // 当前页码
      pageSize: 10, // 每页显示的博客数量
      total: 0, // 博客总数
    };
  },
  computed: {
    // 计算属性用于处理blog.content并生成摘要
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
    getBlogTitle() {
      return (content) => {
        if (content.length <= 16) {
          return content;
        }
        return content.substring(0, 16) + "...";
      };
    },
  },
  methods: {
    myMessage(){
      if (localStorage.getItem("token") == null) {
        this.$router.push({path: '/'})
      } else this.$router.push({path: '/user/userMessage'})
    },
    userLikeBlogs() {
      if (localStorage.getItem("token") == null) {
        this.$router.push({path: '/'})
      } else this.$router.push({path: '/user/likeBLogs'})
    },
    countSetUp() {
      if (localStorage.getItem("token") == null) {
        this.$router.push({path: '/'})
      } else this.$router.push({path: '/user/userEditor'})
    },
    logout() {
      if (localStorage.getItem("token") == null) {
        this.$router.push({path: '/'})
      } else {
        MessageBox.confirm('确定要注销吗？', '确认注销', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          // 用户点击了确定按钮
          localStorage.removeItem("token")
          localStorage.removeItem("user")
          this.$router.push({path: '/login'});
        })
      }
    },
    findMyBLog() {
      if (localStorage.getItem("token") == null) {
        this.$router.push({path: '/'})
      } else this.$router.push({path: '/blog/userBlog'})
    },
    editorBlog() {
      if (localStorage.getItem("token") == null) {
        this.$router.push({path: '/'})
      } else this.$router.push({path: '/blog/blogEditor'})
    },
    lookBlog(id) {
      this.$router.push({path: '/blog/lookBLog', query: {id: id}});
    },
    likeBlog(id) {
      if (localStorage.getItem("token") == null) {
        this.$router.push({path: '/'})
      } else {
        if (this.likeButtonDisabled) {
          this.$message.warning("您点的太快了")
          return;
        }
        this.likeButtonDisabled = true
        this.editBlogForm.blogId = id
        this.$axios.post("isLike/likeBlog", this.editBlogForm).then(res => {
          if (res.data.code === 200) {
            this.$message.success(res.data.data);
            this.pageNum = 1;
            this.queryUserLikeBlog()
            // 根据返回的信息增减点赞数以及更新 blogs 中对应博客的点赞信息
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
              this.queryAll()
              this.likeButtonDisabled = false
            }, 1000);
          } else {
            this.$message.warning("网络异常")
          }
        })
      }
    },
    // 处理每页显示数量的变化
    handleSizeChange(val) {
      this.pageSize = val
      this.queryAll();
    },
    handleCurrentChange(val) {
      this.pageNum = val
      this.queryAll()
    },
    searchBlog() {
      this.$router.push({path: '/blog/search', query: {keyword: this.formInline.keyword}});
    },
    queryUserLikeBlog() {
      if (localStorage.getItem("token") == null) {
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
    queryAll() {
      this.$axios.get("blog/getBlogPage", {
        params: {
          pageNum: this.pageNum,
          pageSize: this.pageSize,
          typeId: this.formInline.typeId,
          title: this.formInline.title
        }
      }).then(res => {
        if (res.data.code === 200) {
          this.blogs = res.data.data.records
          this.total = res.data.data.total
          this.loading = true
        } else {
          this.$message.warning(res.data.message)
        }
      })
    },
    readNumMaxInTwoDays() {
      this.$axios.get("blog/readNumMaxInTwoDays").then(res => {
        if (res.data.code === 200) {
          this.readNumMaxInTwoDaysBlogs = res.data.data
        }
      })
    },
    setUserImage() {
      if (localStorage.getItem("token") == null) {
        this.userImage = ""
      } else {
        this.userImage = JSON.parse(localStorage.getItem("user")).image
      }
    },
    getActiveUserToday() {
      this.$axios.get("user/getActiveUserToday").then(res => {
        if (res.data.code === 200) {
          this.loginCount = res.data.data
        }
      })
    }
  },
  created() {
    // 当组件创建时，调用获取博客列表的函数
    this.queryAll()
    this.queryUserLikeBlog()
    this.getActiveUserToday()
    this.readNumMaxInTwoDays()
    this.setUserImage()
  },
};
</script>

<style scoped>

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
  width: 65%;
  border-bottom: 1px solid #ccc;
  padding-bottom: 10px;
  margin-bottom: 10px;
}

.main-body {
  display: flex;
}

[v-cloak] {
  display: none;
}

.red-like {
  color: red; /* 或者其他您想要的红色样式 */
}

</style>
