<template>
  <div class="blog-app">

    <!-- 主要内容区域 -->
    <main class="main">
      <!-- 搜索栏 -->
      <div class="search-bar" style="margin-top: -12px">
        <div class="search-bar-container" style="margin-top: -15px">
          <el-button type="text">首页</el-button>
          <el-button type="text">新闻</el-button>
          <el-button type="text">博文</el-button>
          <el-button type="text">会员</el-button>
          <el-button type="text">直播</el-button>
          <el-button type="text">发现</el-button>
        </div>
        <div style="margin-left: 500px; padding-top: 10px">
          <el-form :inline="true" :model="formInline" class="user-search">
            <el-form-item>
              <el-input size="small" v-model="formInline.keyword" placeholder="代码改变世界">
                <!-- 在搜索栏中添加一个图标按钮 -->
                <el-button slot="append" icon="el-icon-search" size="small" circle
                           @click="queryByKeyword()"></el-button>
              </el-input>
            </el-form-item>
          </el-form>
        </div>
        <div>
          <i class="el-icon-edit"></i>
          <i class="el-icon-edit"></i>
          <i class="el-icon-edit"></i>
          <el-avatar src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png"></el-avatar>
        </div>
      </div>
      <!--      主要区域-->
      <div class="main-body">
        <!--        右边栏-->
        <div style="width: 150px; background-color: gainsboro">
          <div style="display: flex; flex-direction: column; align-items: center; justify-content: center">
            <a>aaaa</a>
            <a>aaaa</a>
            <a>aaaa</a>
            <a>aaaa</a>
            <a>aaaa</a>
          </div>
        </div>
        <!--        中间博客区域-->
        <div>
          <!-- 博客列表 -->
          <div class="blog-list">
            <!-- 使用循环显示博客列表 -->
            <div v-for="blog in blogs" :key="blog.id" class="blog-item">
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
              <div style="display: flex; font-size: 13px">
                <el-button type="text" style="text-decoration: underline; color: #3a8ee6; margin-left: 10px">
                  {{ blog.bloggerName }}
                </el-button>
                <span style="margin-left: 10px;margin-top: 12px">{{ blog.gmtModified }}</span>
                <el-button type="text" style="margin-left: 10px" class="iconfont icon-dianzan1"
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
        <div style="width: 300px; background-color: gainsboro">
          <div style="height: 400px; background-color: #3a8ee6">
            48小时阅读排行
          </div>
        </div>
      </div>

      <!--      页脚-->
      <div style=" height: 50px; background-color: gainsboro">
        <span>------------------------------------------------------------------------------------</span>
      </div>
    </main>
  </div>
</template>

<script>
export default {
  name: "BlogApp",
  data() {
    return {
      formInline: {
        keyword: ""
      },
      editBlogForm: {
        id: "",
        like: ""
      },
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
  },
  methods: {
    lookBlog(id){
      
    },
    likeBlog(id) {
      this.editBlogForm.id = id
      this.$axios.put("blog/isLikeBlog", this.editBlogForm).then(res => {
        if (res.data.code === 200) {
          this.pageNum = 1
          this.queryAll()
          this.$message.success("修改成功");
        } else {
          this.$message.warning("网络异常")
        }
      })
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
          this.total = res.data.data.total
        } else {
          this.$message.warning(res.data.message)
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
        } else {
          this.$message.warning(res.data.message)
        }
      })
    },
  },
  created() {
    // 当组件创建时，调用获取博客列表的函数
    this.queryAll()

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
  width: 800px;
  border-bottom: 1px solid #ccc;
  padding-bottom: 10px;
  margin-bottom: 10px;
}

.main-body {
  display: flex;
}

</style>
