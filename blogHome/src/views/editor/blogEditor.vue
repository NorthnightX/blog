<template>
  <div>
    <el-container style="height: 100%; width: 100%;">
      <!-- 页头 -->
      <div style="display: flex; flex-direction: column; align-items: center; justify-content: center; width: 100%;">
        <div class="editorHeader" style="width: 100%;">
          <div
              style="display: flex; justify-content: space-between; align-items: center; height: 30px; margin: 2px 10px;">
            <div>
              <el-button style="font-size: 13.5px; font-weight: bold" type="text" @click="toHome()">首页</el-button>
              <el-button style="margin-left: 18px; font-size: 13.5px; font-weight: bold" type="text">新闻</el-button>
              <el-button style="margin-left: 18px; font-size: 13.5px; font-weight: bold" type="text">博文</el-button>
              <el-button style="margin-left: 18px; font-size: 13.5px; font-weight: bold" type="text">会员</el-button>
              <el-button style="margin-left: 18px; font-size: 13.5px; font-weight: bold" type="text">直播</el-button>
              <el-button style="margin-left: 18px; font-size: 13.5px; font-weight: bold" type="text">发现</el-button>
            </div>
            <div>
              <el-button style="font-size: 13.5px; font-weight: bold" type="text">{{ this.user.nickName }}</el-button>
              <el-button style="margin-left: 10px; font-size: 13.5px; font-weight: bold" type="text">博客</el-button>
              <el-button style="margin-left: 10px; font-size: 13.5px; font-weight: bold" type="text">消息</el-button>
              <el-button style="margin-left: 10px; font-size: 13.5px; font-weight: bold" type="text">设置</el-button>
              <el-button style="margin-left: 10px; font-size: 13.5px; font-weight: bold" type="text">退出</el-button>
            </div>
          </div>
        </div>
        <div style="height: 2px; background-color: #ccc; width: 100%;"></div>
        <!--      中间过渡-->
        <div
            style="height: 13%; width: 100%; background-color: white; justify-content: center;align-items: center;display: flex">
          <div style="margin-left: -65%">
            <img src="../../assets/img/adminlogo.png" width="50%">
          </div>
        </div>
        <div style="width: 100%; height: 20px; background-color: cornflowerblue"></div>
        <!--      编辑区-->
        <div style="width: 100%">
          <div style="display: flex; justify-content: space-between;">
            <!-- 编辑区的右侧工具栏 -->
            <div style="width: 13%; background-color: whitesmoke; margin-right: 10px;">
              <div style="width: 100%;justify-content: center;align-items: center;display:flex;flex-direction: column">
                <div>
                  <el-button type="text" @click="addBLog()">新建博客</el-button>
                </div>
                <div>
                  <el-button type="text" @click="recycleBin()">回收站</el-button>
                </div>
                <div>
                  <el-button type="text" @click="addBlogType()">新建分类</el-button>
                </div>
                <div>
                  <el-button type="text" @click="allBlogType()">全部分类</el-button>
                </div>
              </div>
            </div>

            <div style="width: 80%; min-height: 580px; height: auto; margin: 0 3%"
                 v-show="!editorBLog && !updateBLogVisible && !recycleBinVisible">
              <div style="margin-top: 15px;width: 100%;display: flex;justify-content: space-between;">
                <div style="width: 30%;">
                  <span style="font-size: 13px">标题</span>
                </div>
                <div style="display: flex; width: 70%;margin-left: 30%">
                  <div style="width: 20%;align-items: center;display: flex;justify-content: center">
                    <span style="font-size: 13px">发布时间</span>
                  </div>
                  <div style="width: 10%;align-items: center;display: flex;justify-content: center">
                    <span style="font-size: 13px">评论数</span>
                  </div>
                  <div style="width: 10%;align-items: center;display: flex;justify-content: center">
                    <span style="font-size: 13px">点击量</span>
                  </div>
                  <div style="width: 10%;align-items: center;display: flex;justify-content: center">
                    <span style="font-size: 13px">操作</span>
                  </div>
                  <div style="width: 10%;align-items: center;display: flex;justify-content: center">
                    <span style="font-size: 13px">删除</span>
                  </div>
                </div>
              </div>
              <div style="height: 1px;width: 100%;background-color: cornflowerblue;margin-top: 10px"></div>
              <div>
                <div>
                  <div v-for="(blog, index) in blogs" :key="blog.id">
                    <div :style="{ display: 'flex', width: '100%', height: '35px', alignItems: 'center',
                    justifyContent: 'space-between', backgroundColor: index % 2 === 1 ? '#f7f7f7' : 'transparent' }">
                      <div class="blogTitle" style="width: 30%;">
                        <span style="font-size: 12px">{{ blog.title }}</span>
                      </div>
                      <div style="display: flex; width: 70%;margin-left: 30%">
                        <div style="width: 20%; align-items: center; display: flex; justify-content: center;">
                          <span style="font-size: 12px">{{ blog.gmtCreate }}</span>
                        </div>
                        <div style="width: 10%; align-items: center; display: flex; justify-content: center;">
                          <span style="font-size: 12px">{{ blog.comment }}</span>
                        </div>
                        <div style="width: 10%; align-items: center; display: flex; justify-content: center;">
                          <span style="font-size: 12px">{{ blog.clickCount }}</span>
                        </div>
                        <div style="width: 10%; align-items: center; display: flex; justify-content: center;">
                          <el-button type="text" size="small" @click="updateBLog(blog)">编辑</el-button>
                        </div>
                        <div style="width: 10%; align-items: center; display: flex; justify-content: center;">
                          <el-button type="text" size="small" @click="deleteBlog(blog.id)">删除</el-button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>


              </div>
            </div>

            <div></div>
            <!-- 新建博客区 -->
            <div style="width: 80%; margin: 0 3%" v-show="editorBLog">
              <div style="margin-top: 1%">
                <el-form>
                  <el-form-item label="标题" prop="title">
                    <el-input v-model="guideDetail.title"></el-input>
                  </el-form-item>
                </el-form>
              </div>
              <span style="color: #666666;font-size: 15px" >上传封面</span>
              <div style="margin-top: 10px">
                <el-avatar shape="square" :src="blogImage" :size="50" @click.native="openFileInput"></el-avatar>
                <input type="file" ref="fileInput" style="display: none" @change="handleFileChange">
              </div>
              <div style="margin-top: 10px;">
                <span style="color: #666666">内容</span>
                <el-form style="margin-top: 10px">
                  <el-form-item prop="content">
                    <mavon-editor
                        v-model="guideDetail.content"
                        ref=md
                        @imgAdd="$imgAdd"></mavon-editor>
                  </el-form-item>
                </el-form>
              </div>
              <div style="margin-top: 10px; background-color: whitesmoke">
                <div style="background-color: cornflowerblue">
                  <span style="color: #666666">分类</span>
                  <el-button style="margin-left: 20px;color: gainsboro" size="medium" type="text"
                             @click="addBlogType()">+ 新建分类
                  </el-button>
                </div>
                <el-form style="margin-top: 10px">
                  <el-form-item prop="content">
                    <el-select v-model="guideDetail.typeId" v-show="types.length > 0" placeholder="请选择分类">
                      <el-option
                          v-for="type in types"
                          :key=type.id
                          :label=type.name
                          :value=type.id>
                      </el-option>
                    </el-select>
                    <el-select disabled v-show="types.length === 0" placeholder="还没有分类哦，新建一个吧">
                    </el-select>
                  </el-form-item>
                </el-form>
              </div>
              <div style="margin-top: 10px; background-color: whitesmoke">
                <div
                    style="background-color: cornflowerblue; height: 35px; justify-content: left;display: flex;align-items: center">
                  <span style="color: #666666">高级选项</span>
                </div>
                <div>
                  <template>
                    <el-radio v-model="guideDetail.isPublic" :label=1>公开</el-radio>
                    <el-radio v-model="guideDetail.isPublic" :label=2>只有我</el-radio>
                  </template>
                </div>
              </div>
              <div style="justify-content: left; display: flex; align-items: center; height: 50px">
                <div>
                  <el-button type="primary" style="background-color: #3366cc;" size="medium" @click="submitForm()">
                    提交
                  </el-button>
                  <el-button type="primary" style="background-color: #3366cc;" size="medium" @click="clearForm()">取消
                  </el-button>
                </div>
              </div>
            </div>
            <!--            回收站-->
            <div  v-show="recycleBinVisible"
                 style="width: 80%; min-height: 580px; height: auto; margin: 0 3%">
              <div style="margin-top: 15px;width: 100%;display: flex;justify-content: space-between;">
                <div style="width: 30%;">
                  <span style="font-size: 13px">标题</span>
                </div>
                <div style="display: flex; width: 70%;margin-left: 30%">
                  <div style="width: 20%;align-items: center;display: flex;justify-content: center">
                    <span style="font-size: 13px">发布时间</span>
                  </div>
                  <div style="width: 10%;align-items: center;display: flex;justify-content: center">
                    <span style="font-size: 13px">评论数</span>
                  </div>
                  <div style="width: 10%;align-items: center;display: flex;justify-content: center">
                    <span style="font-size: 13px">点击量</span>
                  </div>
                  <div style="width: 10%;align-items: center;display: flex;justify-content: center">
                    <span style="font-size: 13px">操作</span>
                  </div>
                </div>
              </div>
              <div style="height: 1px;width: 100%;background-color: cornflowerblue;margin-top: 10px"></div>
              <div v-if="deletedBlog.length === 0">
                <h1>回收站是空的</h1>
              </div>
              <div>
                <div>
                  <div v-for="(blog, index) in deletedBlog" :key="blog.id">
                    <div :style="{ display: 'flex', width: '100%', height: '35px', alignItems: 'center',
                    justifyContent: 'space-between', backgroundColor: index % 2 === 1 ? '#f7f7f7' : 'transparent' }">
                      <div class="blogTitle" style="width: 30%;">
                        <span style="font-size: 12px">{{ blog.title }}</span>
                      </div>
                      <div style="display: flex; width: 70%;margin-left: 30%">
                        <div style="width: 20%; align-items: center; display: flex; justify-content: center;">
                          <span style="font-size: 12px">{{ blog.gmtCreate }}</span>
                        </div>
                        <div style="width: 10%; align-items: center; display: flex; justify-content: center;">
                          <span style="font-size: 12px">{{ blog.comment }}</span>
                        </div>
                        <div style="width: 10%; align-items: center; display: flex; justify-content: center;">
                          <span style="font-size: 12px">{{ blog.clickCount }}</span>
                        </div>
                        <div style="width: 10%; align-items: center; display: flex; justify-content: center;">
                          <el-button type="text" size="small" @click="recoverBlog(blog.id)">恢复</el-button>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <!--            修改区-->
            <div style="width: 80%; margin: 0 3%" v-show="updateBLogVisible">
              <div style="margin-top: 1%">
                <el-form>
                  <el-form-item label="标题" prop="title">
                    <el-input v-model="updateBlogForm.title"></el-input>
                  </el-form-item>
                </el-form>
              </div>
              <span style="color: #666666;font-size: 15px" >上传封面</span>
              <div style="margin-top: 10px">
                <el-avatar shape="square" :src="updateBlogForm.image" :size="50" @click.native="openFileInput"></el-avatar>
                <input type="file" ref="fileInput" style="display: none" @change="handleFileChange">
              </div>
              <div style="margin-top: 10px;">
                <span style="color: #666666">内容</span>
                <el-form style="margin-top: 10px">
                  <el-form-item prop="content">
                    <mavon-editor
                        v-model="updateBlogForm.content"
                        ref=md
                        @imgAdd="$imgAdd"></mavon-editor>
                  </el-form-item>
                </el-form>
              </div>
              <div style="margin-top: 10px; background-color: whitesmoke">
                <div style="background-color: cornflowerblue">
                  <span style="color: #666666">分类</span>
                  <el-button style="margin-left: 20px;color: gainsboro" size="medium" type="text"
                             @click="addBlogType()">+ 新建分类
                  </el-button>
                </div>
                <el-form style="margin-top: 10px">
                  <el-form-item prop="content">
                    <el-select v-model="updateBlogForm.typeId" v-show="types.length > 0" placeholder="请选择分类">
                      <el-option
                          v-for="type in types"
                          :key=type.id
                          :label=type.name
                          :value=type.id>
                      </el-option>
                    </el-select>
                    <el-select disabled v-show="types.length === 0" placeholder="还没有分类哦，新建一个吧">
                    </el-select>
                  </el-form-item>
                </el-form>
              </div>
              <div style="margin-top: 10px; background-color: whitesmoke">
                <div
                    style="background-color: cornflowerblue; height: 35px; justify-content: left;display: flex;align-items: center">
                  <span style="color: #666666">高级选项</span>
                </div>
                <div>
                  <template>
                    <el-radio v-model="updateBlogForm.isPublic" :label=1>公开</el-radio>
                    <el-radio v-model="updateBlogForm.isPublic" :label=2>只有我</el-radio>
                  </template>
                </div>
              </div>
              <div style="justify-content: left; display: flex; align-items: center; height: 50px">
                <div>
                  <el-button type="primary" style="background-color: #3366cc;" size="medium"
                             @click="submitUpdateForm()">
                    提交
                  </el-button>
                  <el-button type="primary" style="background-color: #3366cc;" size="medium" @click="clearForm()">取消
                  </el-button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- 页面底部 -->
        <div style="height: 5%;width: 100%;background-color: #888888">
          <div
              style="height: 80%; width: 100%;margin-top: 3.5px; background-color: white; display: flex;justify-content: right">
            <div style="color: #888888; font-size: 13px; display: flex;justify-content: center;align-items: center">
              用代码改变世界
            </div>
          </div>
        </div>
        <!--        新建分类-->
        <el-dialog :visible.sync="addTypeFormVisible" width="30%" @click='closeDialog("edit")'>
          <el-form label-width="80px" ref="editAddTypeForm" :model="editAddTypeForm" :rules="rules">
            <el-form-item label="名称" prop="name">
              <el-input size="small" v-model="editAddTypeForm.name" auto-complete="off"
                        placeholder="请输入分类名称"></el-input>
            </el-form-item>
            <el-form-item label="可见性" prop="isPublic">
              <template>
                <el-radio v-model="editAddTypeForm.isPublic" :label=1>公开</el-radio>
                <el-radio v-model="editAddTypeForm.isPublic" :label=2>只有我</el-radio>
              </template>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button size="small" @click='closeDialog("edit")'>取消</el-button>
            <el-button size="small" type="primary" class="title" @click="submitAddForm('editAddTypeForm')">保存
            </el-button>
          </div>
        </el-dialog>
      </div>
    </el-container>
  </div>

</template>

<script>
export default {
  name: "BlogApp",
  data() {
    return {
      blogImage: "",
      deletedBlog: [],
      recycleBinVisible: false,
      blogs: [],
      updateBLogVisible: false,
      editorBLog: false,
      user: {},
      editAddTypeForm: {
        name: "",
        isPublic: 1,
      },
      addTypeFormVisible: false,
      types: [],
      rules: {
        name: [
          {required: true, message: '名称不能为空', trigger: 'blur'}
        ]
      },
      guideDetail: {
        image: '',
        content: '',
        title: '',
        typeId: '',
        isPublic: 1
      },
      updateBlogForm: {
        image:'',
        content: '',
        title: '',
        typeId: '',
        isPublic: 1
      },
    };
  },
  computed: {},
  methods: {
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
            this.blogImage = url;
            this.guideDetail.image = url;
          } else {
            this.$message('网络异常');
          }
        });
      }
    },
    recoverBlog(id){
      this.$axios.put(`blog/recoverBlog/${id}`).then(res => {
        if(res.data.code === 200){
          this.$message.success("修改成功")
          setTimeout(() => {
            this.queryBlogByUser()
            this.recycleBinVisible = false
          }, 500);
        }
        else{
          this.$message.warning("网络异常")
        }
      })
    },
    allBlogType() {

    },
    recycleBin() {
      this.recycleBinVisible = true
      this.editorBLog = false
      this.updateBLogVisible = false
      this.$axios.get(`blog/recycleBinBlog`).then(res => {
          if(res.data.code === 200){
            this.deletedBlog = res.data.data
          }
          else{
            this.$message.warning("网络异常")
          }
      })
    },
    addBLog() {
      this.editorBLog = true
      this.recycleBinVisible = false
      this.updateBLogVisible = false
    },
    updateBLog(blog) {
      this.updateBlogForm = {...blog}
      this.updateBLogVisible = true
    },
    deleteBlog(id) {
      const confirmed = confirm('确认要删除吗？');
      if (confirmed) {
        this.$axios.put(`/blog/deleteBlog/${id}`).then(res => {
          if (res.data.code === 200) {
            this.$message.success("删除成功,30天内可以通过回收在恢复该博客")
            setTimeout(() => {
              this.queryBlogByUser()
            }, 500);
          } else {
            this.$message.warning("网络开小差了")
          }
        })
      }
    },
    submitUpdateForm() {
      this.$axios.put("blog/updateBlog", this.updateBlogForm).then(res => {
        if(res.data.code === 200){
          this.$message.success("修改成功")
          setTimeout(() => {
            this.queryBlogByUser(this.user.id)
          }, 500);
        }
        else{
          this.$message.warning("网络异常")
        }
        this.updateBLogVisible = false
      })
    },
    submitAddForm() {
      this.$axios.post("/blogType/addType", this.editAddTypeForm).then(res => {
        if (res.data.code === 200) {
          this.selectTypeByLoginUser()
          this.$message.success("保存成功")
          this.addTypeFormVisible = false
          this.editAddTypeForm.name = ''
        } else {
          this.$message.warning("网络异常")
        }
      })
    },
    addBlogType() {
      this.addTypeFormVisible = true
    },
    toHome() {
      this.$router.push({path: '/blog/home'});
    },
    closeDialog() {
      this.addTypeFormVisible = false
      this.editAddTypeForm.name = ''
      this.editAddTypeForm.isPublic = 1
    },
    clearForm() {
      const confirmed = confirm('确认要取消吗？');
      if (confirmed) {
        this.guideDetail.content = '';
        this.guideDetail.title = '';
        this.guideDetail.typeId = '';
        this.guideDetail.isPublic = 1;
        this.editorBLog = false
        this.updateBLogVisible = false
      }
    },
    $imgAdd(pos, $file) {
      var formdata = new FormData();
      formdata.append('image', $file);
      this.$axios.post("upload/uploadBlogImage", formdata).then(res => {
        if (res.status === 200) {
          var url = res.data.data;
          this.$refs.md.$img2Url(pos, url)
        } else {
          this.$message("网络异常")
        }
      })
    },
    submitForm() {
      this.$axios.post("blog/addBlog", this.guideDetail).then(res => {
        if(localStorage.getItem("token") == null){
          this.$message.warning("请先登录")
          return;
        }
        if (res.data.code === 200) {
          this.$message.success("保存成功")
          this.guideDetail.content = '';
          this.guideDetail.title = '';
          this.guideDetail.typeId = '';
          this.guideDetail.isPublic = 1;
          this.editorBLog = false
        } else {
          this.$message.warning(res.data.data)
        }
      })
    },
    selectTypeByLoginUser() {
      this.$axios.get("blogType/getTypeByUser").then(res => {
        if (res.data.code === 200) {
          this.types = res.data.data
        } else {
          this.$message.warning(res.data.data)
        }
      })
    },
    queryBlogByUser() {
      this.$axios.get("blog/blogByUser").then(res => {
        if (res.data.code === 200) {
          this.blogs = res.data.data;
          this.loading = true
        } else {
          this.$message.warning("网络异常")
        }
      })
    }
  },
  created() {
    this.user = JSON.parse(localStorage.getItem("user"))
    this.queryBlogByUser()
    this.selectTypeByLoginUser()
  }
};
</script>


<style scoped>
/* Your styles here */
</style>

