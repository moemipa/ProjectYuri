package yuri.projectyuri.config

import com.google.common.base.Predicates
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.ComponentScan
import org.springframework.context.annotation.Configuration
import springfox.documentation.builders.ApiInfoBuilder
import springfox.documentation.builders.PathSelectors
import springfox.documentation.builders.RequestHandlerSelectors
import springfox.documentation.service.ApiInfo
import springfox.documentation.spi.DocumentationType
import springfox.documentation.spring.web.plugins.Docket
import springfox.documentation.swagger2.annotations.EnableSwagger2
import java.text.SimpleDateFormat
import java.util.*
import org.springframework.boot.context.properties.ConfigurationProperties
import org.springframework.context.annotation.PropertySource
import org.springframework.stereotype.Component


/**
 * http://localhost:8070/swagger-ui.html
 */
@Configuration
@EnableSwagger2
@ComponentScan("yuri.projectyuri")
class SwaggerConfig {

    @Bean
    fun api(): Docket = Docket(DocumentationType.SWAGGER_2)
        .select()
        .apis(RequestHandlerSelectors.any())
        .paths(Predicates.not(PathSelectors.regex("/error")))
        .build()
        .apiInfo(apiInfo())

    private fun apiInfo(): ApiInfo = ApiInfoBuilder()
        .title("REST API")
        .version("0.1")
        .build()
}

@Component
@ConfigurationProperties(prefix = "file")
@PropertySource("classpath:file-storage.properties")
class FileStorageProperties {
    var uploadDir: String? = null
}

