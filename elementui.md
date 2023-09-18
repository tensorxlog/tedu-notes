上传图片：
```
<el-upload
    action="https://jsonplaceholder.typicode.com/posts/"
    list-type="picture-card"
    :on-preview="handlePictureCardPreview"
    :on-remove="handleRemove">
  <i class="el-icon-plus"></i>
</el-upload>
```

按钮形状的单选：
```
<el-radio-group v-model='c.type'>
    <el-radio-button label='1'>烘焙食谱</el-radio-button>
    <el-radio-button label='2'>烘焙视频</el-radio-button>
    <el-radio-button label='3'>行业资讯</el-radio-button>
</el-radio-group>
```

圆形单选：
```
<el-select v-model='c.categoryId'>
    <el-option label='面包' value='1'></el-option>
    <el-option label='小食' value='1'></el-option>
    <el-option label='家常菜' value='1'></el-option>
</el-select>
```

el-menu-item中的index可以直接指定跳转链接地址，使用并在el-menu中加上router属性即可实现跳转：
<el-menu active-text-color='orange' router style='border: 0'>
    <el-menu-item index="/personal/index">个人信息</el-menu-item>
    <el-menu-item index="/personal/management">稿件管理</el-menu-item>
</el-menu>

