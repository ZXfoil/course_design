import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/UserView.vue'
import Layout from '../layout/Layout.vue'
import LoginView from "@/views/LoginView";

const routes = [
  {
    path: '/',
    name: 'Layout',
    component: Layout,
    redirect: "/book",
    children: [
      {
        path: 'user',
        name: 'UserView',
        component: () => import("@/views/UserView"),
      },
      {
        path: 'person',
        name: 'PersonView',
        component: () => import("@/views/PersonView"),
      },
      {
        path: 'book',
        name: 'BookView',
        component: () => import("@/views/BookView"),
      },
      {
        path: 'news',
        name: 'NewsView',
        component: () => import("@/views/NewsView"),
      },
    ]
  },
  {
    path: '/login',
    name: 'LoginView',
    component: () => import("@/views/LoginView")
  },
  {
    path: '/register',
    name: 'RegisterView',
    component: () => import("@/views/RegisterView")
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
