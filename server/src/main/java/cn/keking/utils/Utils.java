package cn.keking.utils;

/**
 * @Author mingyuan
 * @Date 2020.06.12 10:25
 */


import com.alibaba.fastjson.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;
import java.util.Base64;

import javax.servlet.http.HttpSession;
import java.io.*;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Utils {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    static int count=0;

//    static String[] visualTemplateIds={"4996e027-209b-4121-907b-1ed36a417d22","f73f31ff-2f23-4c7a-a57d-39d0c7a6c4e6","d3605b83-af8d-491c-91b3-a0e0bf3fe714"};

    public static class Method {
        public static String POST = "POST";
        public static String GET = "GET";
    }



    public static String getMd5ByFile(File file) throws FileNotFoundException {
        String value = null;
        FileInputStream in = new FileInputStream(file);
        try {
            MappedByteBuffer byteBuffer = in.getChannel().map(FileChannel.MapMode.READ_ONLY, 0, file.length());
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            md5.update(byteBuffer);
            BigInteger bi = new BigInteger(1, md5.digest());
            value = bi.toString(16);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if(null != in) {
                try {
                    in.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return value;
    }

    public static boolean isSameDay(Date day1,Date day2){
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
        String d1=simpleDateFormat.format(day1);
        String d2=simpleDateFormat.format(day2);
        return d1.equals(d2);

    }

    public static String checkLoginStatus(HttpSession httpSession){

        Object object=httpSession.getAttribute("uid");
        if(object==null){
            return null;
        }
        else{
            return object.toString();
        }

    }

    public static JSONObject postJSON(String urlStr, JSONObject jsonParam) {
        try {

            //System.out.println(obj);
            // 创建url资源
            URL url = new URL(urlStr);
            // 建立http连接
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            // 设置允许输出
            conn.setDoOutput(true);

            conn.setDoInput(true);

            // 设置不用缓存
            conn.setUseCaches(false);
            // 设置传递方式
            conn.setRequestMethod("POST");
            // 设置维持长连接
            conn.setRequestProperty("Connection", "Keep-Alive");
            // 设置文件字符集:
            conn.setRequestProperty("Charset", "UTF-8");
            //转换为字节数组
            byte[] data = (jsonParam.toJSONString()).getBytes();

            // 设置文件长度
            conn.setRequestProperty("Content-Length", String.valueOf(data.length));

            // 设置文件类型:
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");


            // 开始连接请求
            conn.connect();
            OutputStream out = conn.getOutputStream();
            // 写入请求的字符串
            out.write(data);
            out.flush();
            out.close();

            System.out.println(conn.getResponseCode());
            System.out.println(conn.getResponseMessage());

            // 请求返回的状态
            if (conn.getResponseCode() == 200) {
                System.out.println("连接成功");
                // 请求返回的数据
                InputStream in = conn.getInputStream();
                String a = null;
                try {
                    byte[] data1 = new byte[in.available()];
                    in.read(data1);
                    // 转成字符串
                    a = new String(data1);
                    System.out.println(a);
                    return JSONObject.parseObject(a);
                } catch (Exception e1) {
                    // TODO Auto-generated catch block
                    e1.printStackTrace();
                    return null;
                }
            } else {
                System.out.println("no++");
                return null;
            }

        } catch (Exception e) {
            System.out.println(e);
            return null;
        }

    }

    public static JSONObject connentURL(String method, String urlStr) {
        try {
            URL url = new URL(urlStr);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod(method);
            connection.setConnectTimeout(3000);
            connection.connect();
            // 取得输入流，并使用Reader读取
            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));//设置编码,否则中文乱码
            String lines = "";
            String strResponse = "";
            while ((lines = reader.readLine()) != null) {
                strResponse += lines;
            }
            JSONObject jsonResponse = JSONObject.parseObject(strResponse);

            reader.close();

            connection.disconnect();

            return jsonResponse;


        } catch (MalformedURLException e) {
            e.printStackTrace();
            return null;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }

    }

    public static List<String> saveFiles(List<MultipartFile> files, String path, String uid, String suffix,List<String> result) {
        new File(path).mkdirs();


        for (MultipartFile file : files) {
            String fileName = file.getOriginalFilename();
            fileName = "/" + uid + "/" + new Date().getTime() + "_" + fileName;
            result.add(suffix + fileName);
            int size = (int) file.getSize();
            System.out.println(fileName + "-->" + size);

            if (file.isEmpty()) {
                continue;
            } else {
                File dest = new File(path + fileName);
                if (!dest.getParentFile().exists()) { // 判断文件父目录是否存在
                    dest.getParentFile().mkdir();
                }
                try {
                    file.transferTo(dest);
                } catch (Exception e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                    return null;
                }
            }
        }
        return result;
    }


    /**
     * 根据路径删除指定的目录或文件，无论存在与否
     *
     * @param sPath 要删除的目录或文件
     * @return 删除成功返回 true，否则返回 false。
     */
    public static boolean delete(String sPath) {
        boolean flag = false;
        File file = new File(sPath);
        // 判断目录或文件是否存在
        if (!file.exists()) {  // 不存在返回 false
            return flag;
        } else {
            // 判断是否为文件
            if (file.isFile()) {  // 为文件时调用删除文件方法
                return deleteFile(sPath);
            } else {  // 为目录时调用删除目录方法
                return deleteDirectory(sPath);
            }
        }
    }

    /**
     * 删除单个文件
     *
     * @param sPath 被删除文件的文件名
     * @return 单个文件删除成功返回true，否则返回false
     */
    public static boolean deleteFile(String sPath) {
        Boolean flag = false;
        File file = new File(sPath);
        // 路径为文件且不为空则进行删除
        if (file.isFile() && file.exists()) {
            file.delete();
            flag = true;
        }
        return flag;
    }

    /**
     * 删除目录（文件夹）以及目录下的文件
     *
     * @param sPath 被删除目录的文件路径
     * @return 目录删除成功返回true，否则返回false
     */
    public static boolean deleteDirectory(String sPath) {
        //如果sPath不以文件分隔符结尾，自动添加文件分隔符
        if (!sPath.endsWith(File.separator)) {
            sPath = sPath + File.separator;
        }
        File dirFile = new File(sPath);
        //如果dir对应的文件不存在，或者不是一个目录，则退出
        if (!dirFile.exists() || !dirFile.isDirectory()) {
            return false;
        }
        boolean flag = true;
        //删除文件夹下的所有文件(包括子目录)
        File[] files = dirFile.listFiles();
        for (int i = files.length - 1; i >= 0; i--) {
            //删除子文件
            if (files[i].isFile()) {
                flag = deleteFile(files[i].getAbsolutePath());
                if (!flag) break;
            } //删除子目录
            else {
                flag = deleteDirectory(files[i].getAbsolutePath());
                if (!flag) break;
            }
        }
        if (!flag) return false;
        //删除当前目录
        if (dirFile.delete()) {
            return true;
        } else {
            return false;
        }
    }


    public static String getUdxSchema(String text,String name){
        int findIndex=text.indexOf(name);
        int startIndex=text.indexOf(">",findIndex+name.length())+1;
        int endIndex=text.indexOf("</DatasetItem>",startIndex);
        return text.substring(startIndex,endIndex);
    }

    public static boolean isChinese(String str) {
        String regEx = "[\u4e00-\u9fa5]";
        Pattern pat = Pattern.compile(regEx);
        Matcher matcher = pat.matcher(str);
        boolean flg = false;
        if (matcher.find())
            flg = true;

        return flg;
    }

    public static String saveBase64Image(String content,String oid,String resourcePath,String htmlLoadPath){
        int startIndex = 0, endIndex = 0, index = 0;
        while (content.indexOf("src=\"data:im", startIndex) != -1) {
            int Start = content.indexOf("src=\"data:im", startIndex) + 5;
            int typeStart = content.indexOf("/", Start) + 1;
            int typeEnd = content.indexOf(";", typeStart);
            String type = content.substring(typeStart, typeEnd);
            startIndex = typeEnd + 8;
            endIndex = content.indexOf("\"", startIndex);
            String imgStr = content.substring(startIndex, endIndex);

            String imageName = "/detailImage/" + oid + "/" + oid + "_" + (index++) + "." + type;
            Utils.base64StrToImage(imgStr, resourcePath + imageName);

            content = content.substring(0, Start) + htmlLoadPath + imageName + content.substring(endIndex, content.length());
        }
        return content;
    }

    //base64字符串转化成图片
    public static boolean base64StrToImage(String imgStr, String path) {
        if (imgStr == null)
            return false;
        Base64.Decoder decoder = Base64.getDecoder();
        try {
            // 解密
            byte[] b = decoder.decode(imgStr);
            // 处理数据
            for (int i = 0; i < b.length; ++i) {
                if (b[i] < 0) {
                    b[i] += 256;
                }
            }
            //文件夹不存在则自动创建
            File tempFile = new File(path);

            if (!tempFile.getParentFile().exists()) {
                tempFile.getParentFile().mkdirs();
            }
            OutputStream out = new FileOutputStream(tempFile);
            out.write(b);
            out.flush();
            out.close();
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public static void count(){
        System.out.println("finish:"+(++count));
    }
}

