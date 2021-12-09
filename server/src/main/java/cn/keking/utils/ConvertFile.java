package cn.keking.utils;
import cn.hutool.core.io.FileUtil;
import cn.hutool.core.io.IoUtil;
import cn.hutool.core.text.csv.CsvReader;
import cn.hutool.core.text.csv.CsvRow;
import cn.hutool.core.text.csv.CsvRowHandler;
import cn.hutool.core.text.csv.CsvUtil;
import cn.hutool.core.util.CharsetUtil;
import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.ExcelWriter;
import com.alibaba.excel.support.ExcelTypeEnum;
import com.alibaba.excel.write.builder.ExcelWriterBuilder;
import com.alibaba.excel.write.metadata.WriteSheet;
import com.google.common.collect.Lists;

import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * @author yang
 * @date 2020-09-13 10:40
 * @des
 * @email 1249492252@qq.com
 */

public class ConvertFile {
    private void CvsToExcelUtil() {
    }


    /**
     * csv to xlsx
     * @param src csv文件
     * @param des xlsx 文件
     * @throws Exception
     */
    public static Boolean csv2xlsx(String src, String des) throws Exception {
        //计时器

        long startTime = System.currentTimeMillis();
        CsvReader reader = CsvUtil.getReader();
        int batchSize = 1000;
        OutputStream out = null;
        ExcelWriter excelWriter = null;
        AtomicInteger atomicInteger = new AtomicInteger();
        //从文件中读取CSV数据
        try {

            //初始化excel
            out = new FileOutputStream(des);
            // excelWriter = new ExcelWriter(out, ExcelTypeEnum.XLSX, false);
            ExcelWriterBuilder writerBuilder = EasyExcel.write(out);
            writerBuilder.excelType(ExcelTypeEnum.XLSX);
            writerBuilder.autoCloseStream(true);
            excelWriter = writerBuilder.build();
            // Sheet sheet1 = new Sheet(1, 0);
            WriteSheet sheet1 = new WriteSheet();
            sheet1.setSheetName("first");

            //防止重复扩容
            // List<List<String>> dataList = Lists.newArrayListWithCapacity(batchSize);
            List<List<String>> dataList = Lists.newArrayListWithExpectedSize(batchSize);
            ExcelWriter finalExcelWriter = excelWriter;
            reader.read(FileUtil.getReader(src, CharsetUtil.CHARSET_GBK), new CsvRowHandler() {

                @Override
                public void handle(CsvRow csvRow) {
                    dataList.add(Arrays.asList(csvRow.toArray(new String[csvRow.size()])));
                    //释放内存
                    if(dataList.size()>=batchSize){
                        finalExcelWriter.write(dataList, sheet1);
                        dataList.clear();
                        atomicInteger.set(atomicInteger.get()+batchSize);
                    }
                }
            });
            atomicInteger.set(atomicInteger.get()+dataList.size());
            excelWriter.write(dataList, sheet1);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        } finally {
            if(excelWriter!=null){
                excelWriter.finish();
            }
            IoUtil.close(out);
        }

        System.out.println("csv to xlsx 转换成功\t" + "读取并转换条数： " + atomicInteger.get() + "\t转换总耗时： " + (System.currentTimeMillis() - startTime)/1000.0 + "s");
        return true;
        // Log.info("读取并转换数据：{}条",atomicInteger.get());
        // log.info("转换总耗时{}秒", clock.stop().getSeconds());
    }

    public static void main(String[] args) throws Exception {
        //测试
        csv2xlsx("C:\\Users\\wutian\\Desktop\\test.csv","C:\\Users\\wutian\\Desktop\\test.xlsx");
    }
}
