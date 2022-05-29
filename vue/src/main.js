import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

import ElementPlus from 'element-plus'
import * as ElIcons from '@element-plus/icons-vue'
import 'element-plus/dist/index.css'
import '@/assets/css/global.css'

import 'dayjs/locale/zh-cn'
import locale from 'element-plus/lib/locale/lang/zh-cn'

const app = createApp(App)

for (const name in ElIcons){
	app.component(name,ElIcons[name])
}
app.use(store).use(router).use(ElementPlus, { locale }).mount('#app')