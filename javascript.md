Vue的使用：

```js
<div>{{info}}</div>    
<script>
    let v = new Vue({
        el: 'body>div',
        data() {
            return {
                info: 'hello vue!' 
            };
        }
    })
</script>
```

