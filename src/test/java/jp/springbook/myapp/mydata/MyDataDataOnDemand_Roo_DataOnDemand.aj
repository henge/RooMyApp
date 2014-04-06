// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package jp.springbook.myapp.mydata;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import jp.springbook.myapp.mydata.MyData;
import jp.springbook.myapp.mydata.MyDataDataOnDemand;
import org.springframework.stereotype.Component;

privileged aspect MyDataDataOnDemand_Roo_DataOnDemand {
    
    declare @type: MyDataDataOnDemand: @Component;
    
    private Random MyDataDataOnDemand.rnd = new SecureRandom();
    
    private List<MyData> MyDataDataOnDemand.data;
    
    public MyData MyDataDataOnDemand.getNewTransientMyData(int index) {
        MyData obj = new MyData();
        setAge(obj, index);
        setMail(obj, index);
        setMemo(obj, index);
        setName(obj, index);
        return obj;
    }
    
    public void MyDataDataOnDemand.setAge(MyData obj, int index) {
        Integer age = new Integer(index);
        obj.setAge(age);
    }
    
    public void MyDataDataOnDemand.setMail(MyData obj, int index) {
        String mail = "mail_" + index;
        obj.setMail(mail);
    }
    
    public void MyDataDataOnDemand.setMemo(MyData obj, int index) {
        String memo = "memo_" + index;
        obj.setMemo(memo);
    }
    
    public void MyDataDataOnDemand.setName(MyData obj, int index) {
        String name = "name_" + index;
        obj.setName(name);
    }
    
    public MyData MyDataDataOnDemand.getSpecificMyData(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        MyData obj = data.get(index);
        Long id = obj.getId();
        return MyData.findMyData(id);
    }
    
    public MyData MyDataDataOnDemand.getRandomMyData() {
        init();
        MyData obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return MyData.findMyData(id);
    }
    
    public boolean MyDataDataOnDemand.modifyMyData(MyData obj) {
        return false;
    }
    
    public void MyDataDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = MyData.findMyDataEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'MyData' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<MyData>();
        for (int i = 0; i < 10; i++) {
            MyData obj = getNewTransientMyData(i);
            try {
                obj.persist();
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}