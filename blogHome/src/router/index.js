import Vue from 'vue'
import VueRouter from 'vue-router'
import {Message} from 'element-ui';
import login from '../views/login/loginBlog.vue';
Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: '',
    component: login,
    hidden: true,
    meta: {
      requireAuth: false
    }
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('../views/login/loginBlog.vue')
  },
  {
    path: '/blog/home',
    name: 'home',
    component: () => import('../views/home/home.vue')
  },
  {
    path: '/blog/search',
    name: 'search',
    component:  () => import("../views/search/searchPage.vue")
  },
  {
    path: '/blog/lookBlog',
    name: 'lookBlog',
    component:  () => import("../views/look/lookBlog.vue")
  },
  {
    path: '/blog/blogEditor',
    name: 'blogEditor',
    component:  () => import("../views/editor/blogEditor.vue")
  },
  {
    path: '/blog/userBlog',
    name: 'userBlog',
    component:  () => import("../views/user/userBlog.vue")
  },
  {
    path: '/user/userEditor',
    name: 'userEditor',
    component:  () => import("../views/user/userEditor.vue")
  },
  {
    path: '/user/likeBLogs',
    name: 'userLikeBLogs',
    component:  () => import("../views/user/userLikeBLogs.vue")
  },
  {
    path: '/user/userMessage',
    name: 'userMessage',
    component: () => import("../views/user/userMsg.vue")
  }
]





const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

// router.beforeEach((to, from, next) => {
//   if (to.path === '/' || to.path === '/reg' || to.path === '/login') {
//     return next()
//   } else {
//     let user = localStorage.getItem('token')
//     if (user != null) {
//       //校验token
//       return next()
//     } else {
//       Message.error('用户未登录')
//       return next('/')
//     }
//   }
// })
export default router
