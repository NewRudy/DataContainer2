<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=yes, initial-scale=1.0"/>
    <title>数据中转服务器</title>
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
    <h1>数据中转服务器测试界面</h1>
    <div class='head-font' style='margin-bottom: 20px; border: 1px solid #ccc; '>
        主要提供三方面服务：数据上传、下载，数据预览，GIS 处理工具。<a href='https://github.com/Ting-xin/DataContainer2'>项目地址</a>
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
                    接入说明
            </h4>
        </div>
        <div class="panel-body">
            <div>
                <a href='https://documenter.getpostman.com/view/8944866/TzCJe9KD#887e048e-7322-4b0f-933a-496a0e6b5874'>接口地址</a>  实现了小文件、批量文件、大文件、断点续传的上传下载。其中小文件采用 /data 的 Restful 风格的接口,示例<a href='http://111.229.14.128:9000/api/v1/buckets/test/objects/download?prefix=dGVtcC5odG1s'>下载地址</a>，代码如下：

                <pre style="background-color: #2f332a;color: #cccccc">
                    let uploadUrl = 'http://221.226.60.2:8082/data'
                    let formData = new FormData()
                    formData.append('name', document.getElementById('name').value)
                    formData.append('datafile', document.getElementById('inputFile').files[0])
                    fetch(uploadUrl, {method: 'POST', body: formData})
                    .then(response => {
                        if(response.status == 200){ 
                            return response.json()
                        }
                        else throw new Error('服务端错误')
                    })
                    .then((data) => {
                        alert('上传成功')
                        let downloadUrl = uploadUrl + '/' + data.data.id
                        window.locatoin.href = downloadUrl
                        alert('下载成功')
                    })
                    .catch(alert)
                </pre>
            </div>
        </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                        文件上传下载简单测试
                </h4>
            </div>
            <div class="panel-body">
                <div style="padding: 8px;">
                    <form enctype="multipart/form-data" id="fileUpload">
                        <div class='common-font' style='display: inline-block'>名字：</div>
                        <input id="name1" class='input-class' style='margin-right: 50px'/>
                        <div class='common-font' style='display: inline-block'>选择一个文件：</div>
                        <input id='inputFile1' type="file" class='input-class' style='margin-right: 60px'/>
                        <input type="button" id="uploadBtn1" value=" 上 传 " class='btn btn-default'/>
                        <input type="button" id="downloadBtn1" value=" 下载 " class='btn btn-success'/>
                    </form>
                </div>
            </div>
            <div class="panel-body">
                <div style="padding: 8px;">
                    <form enctype="multipart/form-data" id="fileUpload">
                        <div class='common-font' style='display: inline-block'>名字：</div>
                        <input id="name2" class='input-class' style='margin-right: 50px'/>
                        <div class='common-font' style='display: inline-block'>选择多个文件：</div>
                        <input id='inputFile2' type="file" multiple="multiple" class='input-class' style='margin-right: 60px'/>
                        <input type="button" id="uploadBtn2" value=" 上 传 " class='btn btn-default'/>
                        <input type="button" id="downloadBtn2" value=" 下载 " class='btn btn-success'/>
                    </form>
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
                    接入说明
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
                    输入下载地址预览文件
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
                    预览测试
            </h4>
        </div>
        <div class="panel-body">
            <#if fileUploadDisable == false>
                <div style="padding: 10px">
                    <form enctype="multipart/form-data" id="fileUpload">
                        <input type="file" name="file" class='input-class' style="width: 600px"/>
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


    <!-- 常用GIS 处理工具,主要针对地理数据 -->
    <div class="panel panel-primary">
      <div class="panel-heading">
      <h2 class="text-center">GIS 处理工具(正在探索中)</h2>
      </div>
      <#--  <div class="panel-body">
        <div class="panel panel-default">
        <div class="panel-heading">
            <h4 class="panel-title">
                    接入说明
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
        </div>  -->
        </div>
      </div>
    </div>

</div>

<script>
    let uploadUrl = 'http://221.226.60.2:8082/data'
    let viewUrl = 'http://221.226.60.2:8082/onlinePreview?url='
    let downloadUrl1 = '#'
    let downloadUrl2 = '#'

    function uploadFile(idName = 1 ) {
        try{
            let formData = new FormData()
            formData.append('name', document.getElementById('name' + idName).value)
            if(idName == 1) {
                formData.append('datafile', document.getElementById('inputFile' + idName).files[0])
            } else {
                let files = document.getElementById('inputFile' + idName).files
                for(let i = 0; i < files.length; ++i) {
                    formData.append('datafile', files[i])
                }
            }
            fetch(uploadUrl, {method: 'POST', body: formData})
            .then(response => {
                if(response.status == 200){ 
                    return response.json()
                }
                else throw new Error('服务端错误')
            })
            .then((data) => {
                alert('上传成功')
                if(idName == 1) downloadUrl1 = uploadUrl + '/' + data.data.id
                else downloadUrl2 = uploadUrl + '/' + data.data.id
            })
            .catch(alert)
        } catch(err) {
            alert('上传失败: ', err)
        }        
    }

    function downloadFile(url) {
        try {
            if(url != '#') window.location.href = url
            else alert('请先上传数据')
        } catch(err) {
            alert('下载失败: ', err)
        }  
    }

    document.getElementById('uploadBtn1').addEventListener('click', () => {
        uploadFile(1)
    })
    document.getElementById('uploadBtn2').addEventListener('click', () => {
        uploadFile(2)
    })
    document.getElementById('downloadBtn1').addEventListener('click', () => {
        downloadFile(downloadUrl1)
    })
    document.getElementById('downloadBtn2').addEventListener('click', () => {
        downloadFile(downloadUrl2)
    })



    // 原项目代码，主要是数据预览部分
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
