// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package jp.springbook.myapp.mydata;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;
import jp.springbook.myapp.mydata.MyData;

privileged aspect MyData_Roo_Jpa_Entity {
    
    declare @type: MyData: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long MyData.id;
    
    @Version
    @Column(name = "version")
    private Integer MyData.version;
    
    public Long MyData.getId() {
        return this.id;
    }
    
    public void MyData.setId(Long id) {
        this.id = id;
    }
    
    public Integer MyData.getVersion() {
        return this.version;
    }
    
    public void MyData.setVersion(Integer version) {
        this.version = version;
    }
    
}