// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package jp.springbook.myapp.mydata;

import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import jp.springbook.myapp.mydata.MyData;
import jp.springbook.myapp.mydata.MyDataDataOnDemand;
import jp.springbook.myapp.mydata.MyDataIntegrationTest;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect MyDataIntegrationTest_Roo_IntegrationTest {
    
    declare @type: MyDataIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: MyDataIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: MyDataIntegrationTest: @Transactional;
    
    @Autowired
    MyDataDataOnDemand MyDataIntegrationTest.dod;
    
    @Test
    public void MyDataIntegrationTest.testCountMyDatas() {
        Assert.assertNotNull("Data on demand for 'MyData' failed to initialize correctly", dod.getRandomMyData());
        long count = MyData.countMyDatas();
        Assert.assertTrue("Counter for 'MyData' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void MyDataIntegrationTest.testFindMyData() {
        MyData obj = dod.getRandomMyData();
        Assert.assertNotNull("Data on demand for 'MyData' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'MyData' failed to provide an identifier", id);
        obj = MyData.findMyData(id);
        Assert.assertNotNull("Find method for 'MyData' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'MyData' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void MyDataIntegrationTest.testFindAllMyDatas() {
        Assert.assertNotNull("Data on demand for 'MyData' failed to initialize correctly", dod.getRandomMyData());
        long count = MyData.countMyDatas();
        Assert.assertTrue("Too expensive to perform a find all test for 'MyData', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<MyData> result = MyData.findAllMyDatas();
        Assert.assertNotNull("Find all method for 'MyData' illegally returned null", result);
        Assert.assertTrue("Find all method for 'MyData' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void MyDataIntegrationTest.testFindMyDataEntries() {
        Assert.assertNotNull("Data on demand for 'MyData' failed to initialize correctly", dod.getRandomMyData());
        long count = MyData.countMyDatas();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<MyData> result = MyData.findMyDataEntries(firstResult, maxResults);
        Assert.assertNotNull("Find entries method for 'MyData' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'MyData' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void MyDataIntegrationTest.testFlush() {
        MyData obj = dod.getRandomMyData();
        Assert.assertNotNull("Data on demand for 'MyData' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'MyData' failed to provide an identifier", id);
        obj = MyData.findMyData(id);
        Assert.assertNotNull("Find method for 'MyData' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyMyData(obj);
        Integer currentVersion = obj.getVersion();
        obj.flush();
        Assert.assertTrue("Version for 'MyData' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void MyDataIntegrationTest.testMergeUpdate() {
        MyData obj = dod.getRandomMyData();
        Assert.assertNotNull("Data on demand for 'MyData' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'MyData' failed to provide an identifier", id);
        obj = MyData.findMyData(id);
        boolean modified =  dod.modifyMyData(obj);
        Integer currentVersion = obj.getVersion();
        MyData merged = obj.merge();
        obj.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'MyData' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void MyDataIntegrationTest.testPersist() {
        Assert.assertNotNull("Data on demand for 'MyData' failed to initialize correctly", dod.getRandomMyData());
        MyData obj = dod.getNewTransientMyData(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'MyData' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'MyData' identifier to be null", obj.getId());
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
        Assert.assertNotNull("Expected 'MyData' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void MyDataIntegrationTest.testRemove() {
        MyData obj = dod.getRandomMyData();
        Assert.assertNotNull("Data on demand for 'MyData' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'MyData' failed to provide an identifier", id);
        obj = MyData.findMyData(id);
        obj.remove();
        obj.flush();
        Assert.assertNull("Failed to remove 'MyData' with identifier '" + id + "'", MyData.findMyData(id));
    }
    
}
