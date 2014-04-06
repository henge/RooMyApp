// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package jp.springbook.myapp.mydata;

import jp.springbook.myapp.mydata.ApplicationConversionServiceFactoryBean;
import jp.springbook.myapp.mydata.MyData;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.format.FormatterRegistry;

privileged aspect ApplicationConversionServiceFactoryBean_Roo_ConversionService {
    
    declare @type: ApplicationConversionServiceFactoryBean: @Configurable;
    
    public Converter<MyData, String> ApplicationConversionServiceFactoryBean.getMyDataToStringConverter() {
        return new org.springframework.core.convert.converter.Converter<jp.springbook.myapp.mydata.MyData, java.lang.String>() {
            public String convert(MyData myData) {
                return new StringBuilder().append(myData.getName()).append(' ').append(myData.getMail()).append(' ').append(myData.getAge()).append(' ').append(myData.getMemo()).toString();
            }
        };
    }
    
    public Converter<Long, MyData> ApplicationConversionServiceFactoryBean.getIdToMyDataConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.Long, jp.springbook.myapp.mydata.MyData>() {
            public jp.springbook.myapp.mydata.MyData convert(java.lang.Long id) {
                return MyData.findMyData(id);
            }
        };
    }
    
    public Converter<String, MyData> ApplicationConversionServiceFactoryBean.getStringToMyDataConverter() {
        return new org.springframework.core.convert.converter.Converter<java.lang.String, jp.springbook.myapp.mydata.MyData>() {
            public jp.springbook.myapp.mydata.MyData convert(String id) {
                return getObject().convert(getObject().convert(id, Long.class), MyData.class);
            }
        };
    }
    
    public void ApplicationConversionServiceFactoryBean.installLabelConverters(FormatterRegistry registry) {
        registry.addConverter(getMyDataToStringConverter());
        registry.addConverter(getIdToMyDataConverter());
        registry.addConverter(getStringToMyDataConverter());
    }
    
    public void ApplicationConversionServiceFactoryBean.afterPropertiesSet() {
        super.afterPropertiesSet();
        installLabelConverters(getObject());
    }
    
}
