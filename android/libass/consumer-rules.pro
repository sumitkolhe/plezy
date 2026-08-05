# JNI exports bind by name (Java_co_sumit_harbor_libass_*); keep the names stable.
-keepclasseswithmembernames class co.sumit.harbor.libass.** {
    native <methods>;
}
