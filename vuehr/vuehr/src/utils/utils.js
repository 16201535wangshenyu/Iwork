import {getRequest} from './api'
import {Message} from 'element-ui'

export const isNotNullORBlank = (...args)=> {
  for (var i = 0; i < args.length; i++) {
    var argument = args[i];
    if (argument == null || argument == '' || argument == undefined) {
      Message.warning({message: '数据不能为空!'})
      return false;
    }
  }
  return true;
}
export const initMenu = (router, store)=> {
  if (store.state.routes.length > 0) {
    return;
  }
  getRequest("/config/sysmenu").then(resp=> {
    if (resp && resp.status == 200) {
      var fmtRoutes = formatRoutes(resp.data.data);

      router.addRoutes(fmtRoutes);
      console.log("加载菜单数据")
      console.log(resp.data.data)
      store.commit('initMenu', fmtRoutes);
      store.dispatch('connect');
    }
  })
}
export const formatRoutes = (routes)=> {
  let fmRoutes = [];
  routes.forEach(router=> {

    if (router.children && router.children instanceof Array) {
      router.children = formatRoutes(router.children);
    }
    var meta = {
      keepAlive : router.parent.keepAlive,
      requireAuth :router.parent.requireAuth
    };
    let fmRouter = {
      path: router.parent.path,
      component(resolve){
        if (router.parent.component.startsWith("Home")) {
          require(['../components/' + router.parent.component + '.vue'], resolve)
        } else if (router.parent.component.startsWith("Emp")) {
          require(['../components/emp/' + router.parent.component + '.vue'], resolve)
        } else if (router.parent.component.startsWith("Per")) {
          require(['../components/personnel/' + router.parent.component + '.vue'], resolve)
        } else if (router.parent.component.startsWith("Sal")) {
          require(['../components/salary/' +router.parent. component + '.vue'], resolve)
        } else if (router.parent.component.startsWith("Sta")) {
          require(['../components/statistics/' + router.parent.component + '.vue'], resolve)
        } else if (router.parent.component.startsWith("Sys")) {
          require(['../components/system/' + router.parent.component + '.vue'], resolve)
        }else if (router.parent.component.startsWith("User")) {
          require(['../components/user/' + router.parent.component + '.vue'], resolve)
        }
      },
      name: router.parent.name,
      iconCls: router.parent.iconCls,
      meta: meta,
      children: router.children
    };
    fmRoutes.push(fmRouter);
  })
  return fmRoutes;
}
