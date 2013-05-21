extern "C" {
    void ruby_sysinit(int *, char ***);
    void ruby_init(void);
    void ruby_init_loadpath(void);
    void ruby_script(const char *);
    void ruby_set_argv(int, char **);
    void rb_vm_init_compiler(void);
    void rb_vm_init_jit(void);
    void rb_vm_aot_feature_provide(const char *, void *);
    void *rb_vm_top_self(void);
    void rb_rb2oc_exc_handler(void);
    void rb_exit(int);
void MREP_3D8AF75A56C64615A1ABCA0D514BF4ED(void *, void *);
void MREP_76E7C9F76D7E44158F9372551E2A5016(void *, void *);
void MREP_1E3AFC89E5214872935AF7BB80E879B3(void *, void *);
void MREP_E95D4E8ECDE74D18ADC1933EC7542F81(void *, void *);
void MREP_28E7612159CA480186604C06886C3F41(void *, void *);
void MREP_3E0DE00ABCA14DD5ACE3D0CD0F14D168(void *, void *);
}

extern "C"
void
RubyMotionInit(int argc, char **argv)
{
    static bool initialized = false;
    if (!initialized) {
	ruby_init();
	ruby_init_loadpath();
        if (argc > 0) {
	    const char *progname = argv[0];
	    ruby_script(progname);
	}
#if !__LP64__
	try {
#endif
	    void *self = rb_vm_top_self();
MREP_3D8AF75A56C64615A1ABCA0D514BF4ED(self, 0);
MREP_76E7C9F76D7E44158F9372551E2A5016(self, 0);
MREP_1E3AFC89E5214872935AF7BB80E879B3(self, 0);
MREP_E95D4E8ECDE74D18ADC1933EC7542F81(self, 0);
MREP_28E7612159CA480186604C06886C3F41(self, 0);
MREP_3E0DE00ABCA14DD5ACE3D0CD0F14D168(self, 0);
#if !__LP64__
	}
	catch (...) {
	    rb_rb2oc_exc_handler();
	}
#endif
	initialized = true;
    }
}
