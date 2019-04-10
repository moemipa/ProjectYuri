package yuri.projectyuri

import org.springframework.data.domain.Page
import org.springframework.format.annotation.DateTimeFormat
import java.io.Serializable
import java.util.*
import javax.persistence.*

class Result<T>(val data: T) {
    val code: Int = 0
    val message: String = "成功"
}

class PageResult<T>(page: Page<T>) {
    var totalCount: Long = page.totalElements
    var totalPage: Int = page.totalPages
    var currentPage: Int = page.pageable.pageNumber
    var items: Collection<T> = page.content
}

@Entity
class Production(@Id @GeneratedValue var id: Long) {

    var name: String = ""

    var nameCN: String = ""

    var desp: String = ""

    var info: String = ""

    var coverUrl: String = ""

    var category: ProductionCategory? = null

    @ManyToMany
    var producerList: Collection<Producer> = emptyList()

    @ManyToMany
    var characterList: Collection<Character> = emptyList()

    @OneToMany
    var commentList: Collection<Comment> = emptyList()

}

@Entity
class Producer(@Id @GeneratedValue var id: Long) {

    var avatarUrl: String = ""

    var name: String = ""

    var role: String = ""

}

@Entity
class Character(@Id @GeneratedValue var id: Long) {

    var avatarUrl: String = ""

    var name: String = ""

    @ManyToOne(cascade = [CascadeType.MERGE])
    var cv: Producer? = null
}

@Entity
class Comment(@Id @GeneratedValue var id: Long) {

    var content: String = ""

    @ManyToOne(cascade = [CascadeType.MERGE])
    var author: User? = null

    var date: Date = Date()

}

@Entity
class User(@Id @GeneratedValue var id: Long) {

    var name: String = ""

    var avatarUrl: String = ""

    @OneToMany(mappedBy = "user")
    var productionList: Collection<UserProduction> = emptyList()

}

@Entity
class UserProduction(@EmbeddedId var id: UserProductionID) {

    @Embeddable
    data class UserProductionID(var userID: Long, var productionID: Long): Serializable

    @ManyToOne(cascade = [CascadeType.MERGE])
    var user: User? = null

    @ManyToOne(cascade = [CascadeType.MERGE])
    var production: Production? = null

    var evaluation: Evaluation? = null

    var schedule: Schedule? = null

}

enum class Schedule {
    TODO, DOING, DONE
}

enum class Evaluation {
    LIKE, CRITICISM
}

enum class ProductionCategory {
    GAME, ANIME, COMIC, NOVEL
}




//enum class Gender { MALE, FEMALE }

//@Entity
//class Employee(@Id @GeneratedValue var id: Long) {
//
//    @Column
//    var name: String? = null
//
//    @Column
//    @Enumerated
//    var gender: Gender? = null
//
//    @ManyToOne(cascade = [CascadeType.MERGE])
//    var department: Department? = null
//
//    @Column
//    @Temporal(TemporalType.DATE)
//    @DateTimeFormat(pattern = "yyyy-MM-dd")
//    var birthDate: Date = Date()
//
//    override fun toString(): String = toJsonString()
//}
//
//@Entity
//class Department(@Id @GeneratedValue var id: Long) {
//
//    @Column(unique = true)
//    var departmentName: String? = null
//
//    override fun toString(): String = toJsonString()
//}



