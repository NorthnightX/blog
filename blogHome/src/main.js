import Vue from 'vue'
import App from './App.vue'
import router from './router'
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import './assets/icon/iconfont.css'
import './assets/fonts/fonts.css'
import VueQuillEditor from 'vue-quill-editor'
//引入VueQuillEditor
// 引入样式
import 'quill/dist/quill.core.css'
import 'quill/dist/quill.snow.css'
import 'quill/dist/quill.bubble.css'
Vue.use(VueQuillEditor, /* { 默认全局 } */)
import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'
Vue.use(mavonEditor);
Vue.use(ElementUI);
import axios from "axios";
axios.defaults.baseURL='http://localhost:10100'
Vue.prototype.$axios = axios
Vue.config.productionTip = false
axios.defaults.baseURL='http://localhost:10100'

new Vue({
  router,
  render: h => h(App),

}).$mount('#app')
axios.interceptors.request.use(
    config => {
        let token = localStorage.getItem("token");
        if(token) config.headers.authorization = token
        return config
    }
)
axios.interceptors.response.use(
    response => {
        // 检查是否需要清除 Session Storage 中的 token
        const token= response.headers["authorization"];
        if (token != null) {
            localStorage.setItem("token", token)
        }
        return response;
    }
);