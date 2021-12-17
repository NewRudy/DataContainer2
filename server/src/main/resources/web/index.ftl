<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0"/>
    <title>数据中转测试界面</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="bootstrap-table/bootstrap-table.min.css"/>
    <link rel="stylesheet" href="css/viewer.min.css"/>
    <link rel="stylesheet" href="css/index.css"/>
    <script type="text/javascript" src="js/jquery-3.0.0.min.js"></script>
    <script type="text/javascript" src="js/jquery.form.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="bootstrap-table/bootstrap-table.min.js"></script>
    <script type="text/javascript" src="gitalk/gitalk.min.js"></script>
    <script type="text/javascript" src="js/base64.min.js"></script>
</head>

<body>
<div class="panel-group container" id="accordion">
    <h1>数据中转测试界面</h1>
    <div class='head-font' style='margin-bottom: 20px; border: 1px solid #ccc; '>
        主要提供三方面服务：数据上传、下载，数据预览，数据格式转换。<a href='https://github.com/Ting-xin/DataContainer2'>项目地址</a>
    </div>

    <!-- 数据上传、下载界面 -->
    <div class="panel panel-primary">
      <div class="panel-heading">
      <h2 class="text-center">数据上传、下载</h2>
      </div>
      <div class="panel-body">
        <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                    接入说明
                </a>
            </h4>
        </div>
        <div class="panel-body">
            <div>
                <a href='https://documenter.getpostman.com/view/8944866/TzCJe9KD#887e048e-7322-4b0f-933a-496a0e6b5874'>接口地址</a> 实现小文件、批量文件、大文件、断点续传的上传下载。其中小文件采用 /data 的 Restful 风格的接口,示例如下：

                <pre style="background-color: #2f332a;color: #cccccc">
                    let url = 'http://221.226.60.2:8082/data'
                    let viewUrl = 'http://221.226.60.2:8082/onlinePreview?url='

                    // 上传单文件
                    const formData = new FormData()
                    const fileField = document.querySelector('input[type="file"]')
                    formData.append('name', 'test')
                    formData.append('file', fileField.files[0])

                    fetch(url, {
                    	method: 'POST',
                    	body: formData
                    }).then(res => res.json()).then(data => console.log('success: ', data))
                    .catch((e) => {
                    	console.error('error: ', e)
                    })

                    // 上传多文件
                    const filesField = document.querySelector('input[type="file"][multiple]')
                    const formData2 = new FormData()
                    formData2.append('name', 'multiple files')
                    for(let i = 0; i < filesField.files.length; ++i) {
                    	formData2.append('file' + i, filesField.files[i])
                    }
                    fetch(url, {
                    	method: 'POST',
                    	body: formData2
                    })
                    .then(res => response.json())
                    .then(data => console.log('success: ', data))
                    .catch(e => console.error('error: ', e))

                    // 下载数据
                    let testId = 'dc957046-b884-4911-9e89-e36edd6297f8'
                    let downloadUrl = url + '/' + id
                    window.open(downloadUrl)

                    // 可视化数据
                    window.open(viewUrl + Base64.encode(downloadUrl))

                    // 删除和修改同理
                </pre>
            </div>
        </div>
        </div>
      </div>
    </div>

    <!-- 预览界面 -->
    <div class="panel panel-primary">
      <div class="panel-heading">
      <h2 class="text-center">数据预览</h2>
      </div>
      <div class="panel-body">
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                    接入说明
                </a>
            </h4>
        </div>
        <div class="panel-body">
            <div class='common-class'>
                支持的数据格式有：
                <pre style="background-color: #2f332a;color: #cccccc">
{
    "OFFICE_TYPES": ["docx", "wps", "doc", "xls", "xlsx", "csv", "ppt", "pptx"],
    "PICTURE_TYPES": ["jpg", "jpeg", "png", "gif", "bmp", "ico", "raw"],
    "ARCHIVE_TYPES": ["rar", "zip", "jar", "7-zip", "tar", "gzip", "7z"],
    "TIFF_TYPES": ["tif", "tiff"],
    "OFD_TYPES": ["ofd"],
    "CAD_TYPES": ["dwg", "dxf"],
    "CODES_TYPES": ["java", "c", "php", "go", "python", "py", "js", "html", "ftl", "css", "lua", "sh", "r", "yaml", "yml", "json", "h", "cpp", "cs", "aspx", "jsp"],
    "Markdown_TYPES": ["md"]
}
                </pre>
            </div>
            <div class='common-class'>
                如果你的项目需要接入文件预览项目，达到对docx、excel、ppt、jpg、cad等文件的预览效果，那么通过在你的项目中加入下面的代码就可以成功实现：
                <pre style="background-color: #2f332a;color: #cccccc">
                    let url = 'http://111.229.14.128:9001/test/logo.png'; //要预览文件的地址中必须要有完整的文件名或者该文件是数据中转提供的id
                    // 对url进行编码后调用接口
                    window.open('http://221.226.60.2:8082/onlinePreview?url='+encodeURIComponent(base64Encode(url)));   // 写法1
                    window.open('http://221.226.60.2:8082/onlinePreview?url=' + Base64.encode(url));    // 写法2

                    // 多图片预览
                    let fileUrl =url1+"|"+"url2";//多文件使用“|”字符隔开
                    window.open('http://221.226.60.2:8082/picturesPreview?urls='+encodeURIComponent(base64Encode(fileUrl)));
                </pre>
            </div>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion">
                    输入下载地址预览文件
                </a>
            </h4>
        </div>
        <div class="panel-body">
            <label>文件下载地址：<input type="text" id="_url" style="min-width:50em"/></label>
            <form action="${baseUrl}onlinePreview" target="_blank" id="preview_by_url" style="display: inline-block">
                <input type="hidden" name="url"/>
                <#--  <input type="submit" value="预览">  -->
                <button type='submit' class='btn btn-default'>预览</button>
            </form>
        </div>
    </div>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion"
                   href="#collapseTwo">
                    预览测试
                </a>
            </h4>
        </div>
        <div class="panel-body">
            <#if fileUploadDisable == false>
                <div style="padding: 10px">
                    <form enctype="multipart/form-data" id="fileUpload">
                        <input type="file" name="file" class='input-class'/>
                        <input type="button" id="btnSubmit" value=" 上 传 " class='btn btn-default'/>
                        <div class='common-font' style='display: inline-block'>使用的临时文件接口，每日凌晨3点会统一删除</div>
                    </form>
                </div>
            </#if>
            <div>
                <table id="table" data-pagination="true"></table>
            </div>
        </div>
    </div>
      </div>
    </div>


    <!-- 常用数据格式转换,主要针对地理数据 -->
    <div class="panel panel-primary">
      <div class="panel-heading">
      <h2 class="text-center">数据格式转换</h2>
      </div>
      <div class="panel-body">
        <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
                    接入说明
                </a>
            </h4>
        </div>
        <div class="panel-body">
            <div>
                如果你的项目需要接入文件预览项目，达到对docx、excel、ppt、jpg、cad等文件的预览效果，那么通过在你的项目中加入下面的代码就可以
                成功实现：
                <pre style="background-color: #2f332a;color: #cccccc">
                    let url = 'http://127.0.0.1:8080/file/test.txt'; //要预览文件的地址中必须要有完整的文件名或者该文件是根据数据中转的id
                    window.open('http://127.0.0.1:8012/onlinePreview?url='+encodeURIComponent(base64Encode(url)));
                    // 或者
                    window.open('http://127.0.0.1:8012/onlinePreview?url=' + Base64.encode(url));

                    // 多图片预览
                    let fileUrl =url1+"|"+"url2";//多文件使用“|”字符隔开
                    window.open('http://127.0.0.1:8012/picturesPreview?urls='+encodeURIComponent(base64Encode(fileUrl)));
                </pre>
            </div>

        </div>
        </div>
      </div>
    </div>

</div>

<script>


    function deleteFile(fileName) {
        $.ajax({
            url: '${baseUrl}deleteFile?fileName=' + encodeURIComponent(fileName),
            success: function (data) {
                // 删除完成，刷新table
                if (1 === data.code) {
                    alert(data.msg);
                } else {
                    $('#table').bootstrapTable('refresh', {});
                }
            },
            error: function (data) {
                console.log(data);
            }
        })
    }

    $(function () {
        $('#table').bootstrapTable({
            url: 'listFiles',
            columns: [{
                field: 'fileName',
                title: '文件名'
            }, {
                field: 'action',
                title: '操作'
            },]
        }).on('pre-body.bs.table', function (e, data) {
            // 每个data添加一列用来操作
            $(data).each(function (index, item) {
                item.action = "<a class='btn btn-default' target='_blank' href='${baseUrl}onlinePreview?url=" + encodeURIComponent(Base64.encode('${baseUrl}' + item.fileName)) + "'>预览</a>" +
                    "<a class='btn btn-default' href='javascript:void(0);' onclick='deleteFile(\"" + item.fileName + "\")'>删除</a>";
            });
            return data;
        }).on('post-body.bs.table', function (e, data) {
            return data;
        });

        $('#preview_by_url').submit(function() {
            var _url = $("#_url").val();
            var urlField = $(this).find('[name=url]');
            var b64Encoded = Base64.encode(_url);
            urlField.val(b64Encoded);
        });


        function showLoadingDiv() {
            var height = window.document.documentElement.clientHeight - 1;
            $(".loading_container").css("height", height).show();
        }
        $("#btnSubmit").click(function () {
            showLoadingDiv();
            $("#fileUpload").ajaxSubmit({
                success: function (data) {
                    // 上传完成，刷新table
                    if (1 === data.code) {
                        alert(data.msg);
                    } else {
                        $('#table').bootstrapTable('refresh', {});
                    }
                    $(".loading_container").hide();
                },
                error: function () {
                    alert('上传失败，请联系管理员');
                    $(".loading_container").hide();
                },
                url: 'fileUpload', /*设置post提交到的页面*/
                type: "post", /*设置表单以post方法提交*/
                dataType: "json" /*设置返回值类型为文本*/
            });
        });
        // var gitalk = new Gitalk({
        //     clientID: '525d7f16e17aab08cef5',
        //     clientSecret: 'd1154e3aee5c8f1cbdc918b5c97a4f4157e0bfd9',
        //     repo: 'kkFileView',
        //     owner: 'kekingcn',
        //     admin: ['kekingcn,klboke,gitchenjh'],
        //     language: 'zh-CN',
        //     id: location.pathname,
        //     distractionFreeMode: false
        // })
        // gitalk.render((document.getElementById('comments')))
    });
</script>
</body>
</html>
