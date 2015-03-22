
bin/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
void kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

void
kern_init(void){
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 80 fd 10 00       	mov    $0x10fd80,%edx
  10000b:	b8 16 ea 10 00       	mov    $0x10ea16,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 ea 10 00 	movl   $0x10ea16,(%esp)
  100027:	e8 bd 33 00 00       	call   1033e9 <memset>

    cons_init();                // init the console
  10002c:	e8 44 15 00 00       	call   101575 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 80 35 10 00 	movl   $0x103580,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 9c 35 10 00 	movl   $0x10359c,(%esp)
  100046:	e8 d7 02 00 00       	call   100322 <cprintf>

    print_kerninfo();
  10004b:	e8 06 08 00 00       	call   100856 <print_kerninfo>

    grade_backtrace();
  100050:	e8 8b 00 00 00       	call   1000e0 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 d5 29 00 00       	call   102a2f <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 59 16 00 00       	call   1016b8 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 ab 17 00 00       	call   10180f <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 ff 0c 00 00       	call   100d68 <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 b8 15 00 00       	call   101626 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  10006e:	e8 6d 01 00 00       	call   1001e0 <lab1_switch_test>

    /* do nothing */
    while (1);
  100073:	eb fe                	jmp    100073 <kern_init+0x73>

00100075 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100075:	55                   	push   %ebp
  100076:	89 e5                	mov    %esp,%ebp
  100078:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  10007b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  100082:	00 
  100083:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10008a:	00 
  10008b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100092:	e8 03 0c 00 00       	call   100c9a <mon_backtrace>
}
  100097:	c9                   	leave  
  100098:	c3                   	ret    

00100099 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100099:	55                   	push   %ebp
  10009a:	89 e5                	mov    %esp,%ebp
  10009c:	53                   	push   %ebx
  10009d:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  1000a0:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  1000a3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1000a6:	8d 55 08             	lea    0x8(%ebp),%edx
  1000a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1000ac:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1000b0:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1000b4:	89 54 24 04          	mov    %edx,0x4(%esp)
  1000b8:	89 04 24             	mov    %eax,(%esp)
  1000bb:	e8 b5 ff ff ff       	call   100075 <grade_backtrace2>
}
  1000c0:	83 c4 14             	add    $0x14,%esp
  1000c3:	5b                   	pop    %ebx
  1000c4:	5d                   	pop    %ebp
  1000c5:	c3                   	ret    

001000c6 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000c6:	55                   	push   %ebp
  1000c7:	89 e5                	mov    %esp,%ebp
  1000c9:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000cc:	8b 45 10             	mov    0x10(%ebp),%eax
  1000cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d6:	89 04 24             	mov    %eax,(%esp)
  1000d9:	e8 bb ff ff ff       	call   100099 <grade_backtrace1>
}
  1000de:	c9                   	leave  
  1000df:	c3                   	ret    

001000e0 <grade_backtrace>:

void
grade_backtrace(void) {
  1000e0:	55                   	push   %ebp
  1000e1:	89 e5                	mov    %esp,%ebp
  1000e3:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e6:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000eb:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  1000f2:	ff 
  1000f3:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000f7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000fe:	e8 c3 ff ff ff       	call   1000c6 <grade_backtrace0>
}
  100103:	c9                   	leave  
  100104:	c3                   	ret    

00100105 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100105:	55                   	push   %ebp
  100106:	89 e5                	mov    %esp,%ebp
  100108:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  10010b:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  10010e:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  100111:	8c 45 f2             	mov    %es,-0xe(%ebp)
  100114:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100117:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10011b:	0f b7 c0             	movzwl %ax,%eax
  10011e:	83 e0 03             	and    $0x3,%eax
  100121:	89 c2                	mov    %eax,%edx
  100123:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100128:	89 54 24 08          	mov    %edx,0x8(%esp)
  10012c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100130:	c7 04 24 a1 35 10 00 	movl   $0x1035a1,(%esp)
  100137:	e8 e6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  10013c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100140:	0f b7 d0             	movzwl %ax,%edx
  100143:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100148:	89 54 24 08          	mov    %edx,0x8(%esp)
  10014c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100150:	c7 04 24 af 35 10 00 	movl   $0x1035af,(%esp)
  100157:	e8 c6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  10015c:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100160:	0f b7 d0             	movzwl %ax,%edx
  100163:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100168:	89 54 24 08          	mov    %edx,0x8(%esp)
  10016c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100170:	c7 04 24 bd 35 10 00 	movl   $0x1035bd,(%esp)
  100177:	e8 a6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10017c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100180:	0f b7 d0             	movzwl %ax,%edx
  100183:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100188:	89 54 24 08          	mov    %edx,0x8(%esp)
  10018c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100190:	c7 04 24 cb 35 10 00 	movl   $0x1035cb,(%esp)
  100197:	e8 86 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  10019c:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001a0:	0f b7 d0             	movzwl %ax,%edx
  1001a3:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001a8:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001b0:	c7 04 24 d9 35 10 00 	movl   $0x1035d9,(%esp)
  1001b7:	e8 66 01 00 00       	call   100322 <cprintf>
    round ++;
  1001bc:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001c1:	83 c0 01             	add    $0x1,%eax
  1001c4:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  1001c9:	c9                   	leave  
  1001ca:	c3                   	ret    

001001cb <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001cb:	55                   	push   %ebp
  1001cc:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
	asm volatile (
  1001ce:	83 ec 08             	sub    $0x8,%esp
  1001d1:	cd 78                	int    $0x78
  1001d3:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp"
	    : 
	    : "i"(T_SWITCH_TOU)
	);
}
  1001d5:	5d                   	pop    %ebp
  1001d6:	c3                   	ret    

001001d7 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001d7:	55                   	push   %ebp
  1001d8:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
	asm volatile (
  1001da:	cd 79                	int    $0x79
  1001dc:	89 ec                	mov    %ebp,%esp
	    "int %0 \n"
	    "movl %%ebp, %%esp \n"
	    : 
	    : "i"(T_SWITCH_TOK)
	);
}
  1001de:	5d                   	pop    %ebp
  1001df:	c3                   	ret    

001001e0 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001e0:	55                   	push   %ebp
  1001e1:	89 e5                	mov    %esp,%ebp
  1001e3:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001e6:	e8 1a ff ff ff       	call   100105 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001eb:	c7 04 24 e8 35 10 00 	movl   $0x1035e8,(%esp)
  1001f2:	e8 2b 01 00 00       	call   100322 <cprintf>
    lab1_switch_to_user();
  1001f7:	e8 cf ff ff ff       	call   1001cb <lab1_switch_to_user>
    lab1_print_cur_status();
  1001fc:	e8 04 ff ff ff       	call   100105 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100201:	c7 04 24 08 36 10 00 	movl   $0x103608,(%esp)
  100208:	e8 15 01 00 00       	call   100322 <cprintf>
    lab1_switch_to_kernel();
  10020d:	e8 c5 ff ff ff       	call   1001d7 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100212:	e8 ee fe ff ff       	call   100105 <lab1_print_cur_status>
}
  100217:	c9                   	leave  
  100218:	c3                   	ret    

00100219 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100219:	55                   	push   %ebp
  10021a:	89 e5                	mov    %esp,%ebp
  10021c:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  10021f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100223:	74 13                	je     100238 <readline+0x1f>
        cprintf("%s", prompt);
  100225:	8b 45 08             	mov    0x8(%ebp),%eax
  100228:	89 44 24 04          	mov    %eax,0x4(%esp)
  10022c:	c7 04 24 27 36 10 00 	movl   $0x103627,(%esp)
  100233:	e8 ea 00 00 00       	call   100322 <cprintf>
    }
    int i = 0, c;
  100238:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10023f:	e8 66 01 00 00       	call   1003aa <getchar>
  100244:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100247:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10024b:	79 07                	jns    100254 <readline+0x3b>
            return NULL;
  10024d:	b8 00 00 00 00       	mov    $0x0,%eax
  100252:	eb 79                	jmp    1002cd <readline+0xb4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100254:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100258:	7e 28                	jle    100282 <readline+0x69>
  10025a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100261:	7f 1f                	jg     100282 <readline+0x69>
            cputchar(c);
  100263:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100266:	89 04 24             	mov    %eax,(%esp)
  100269:	e8 da 00 00 00       	call   100348 <cputchar>
            buf[i ++] = c;
  10026e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100271:	8d 50 01             	lea    0x1(%eax),%edx
  100274:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100277:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10027a:	88 90 40 ea 10 00    	mov    %dl,0x10ea40(%eax)
  100280:	eb 46                	jmp    1002c8 <readline+0xaf>
        }
        else if (c == '\b' && i > 0) {
  100282:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  100286:	75 17                	jne    10029f <readline+0x86>
  100288:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10028c:	7e 11                	jle    10029f <readline+0x86>
            cputchar(c);
  10028e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100291:	89 04 24             	mov    %eax,(%esp)
  100294:	e8 af 00 00 00       	call   100348 <cputchar>
            i --;
  100299:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10029d:	eb 29                	jmp    1002c8 <readline+0xaf>
        }
        else if (c == '\n' || c == '\r') {
  10029f:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  1002a3:	74 06                	je     1002ab <readline+0x92>
  1002a5:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  1002a9:	75 1d                	jne    1002c8 <readline+0xaf>
            cputchar(c);
  1002ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1002ae:	89 04 24             	mov    %eax,(%esp)
  1002b1:	e8 92 00 00 00       	call   100348 <cputchar>
            buf[i] = '\0';
  1002b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1002b9:	05 40 ea 10 00       	add    $0x10ea40,%eax
  1002be:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1002c1:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  1002c6:	eb 05                	jmp    1002cd <readline+0xb4>
        }
    }
  1002c8:	e9 72 ff ff ff       	jmp    10023f <readline+0x26>
}
  1002cd:	c9                   	leave  
  1002ce:	c3                   	ret    

001002cf <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002cf:	55                   	push   %ebp
  1002d0:	89 e5                	mov    %esp,%ebp
  1002d2:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1002d8:	89 04 24             	mov    %eax,(%esp)
  1002db:	e8 c1 12 00 00       	call   1015a1 <cons_putc>
    (*cnt) ++;
  1002e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002e3:	8b 00                	mov    (%eax),%eax
  1002e5:	8d 50 01             	lea    0x1(%eax),%edx
  1002e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002eb:	89 10                	mov    %edx,(%eax)
}
  1002ed:	c9                   	leave  
  1002ee:	c3                   	ret    

001002ef <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002ef:	55                   	push   %ebp
  1002f0:	89 e5                	mov    %esp,%ebp
  1002f2:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002ff:	89 44 24 0c          	mov    %eax,0xc(%esp)
  100303:	8b 45 08             	mov    0x8(%ebp),%eax
  100306:	89 44 24 08          	mov    %eax,0x8(%esp)
  10030a:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10030d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100311:	c7 04 24 cf 02 10 00 	movl   $0x1002cf,(%esp)
  100318:	e8 e5 28 00 00       	call   102c02 <vprintfmt>
    return cnt;
  10031d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100320:	c9                   	leave  
  100321:	c3                   	ret    

00100322 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100322:	55                   	push   %ebp
  100323:	89 e5                	mov    %esp,%ebp
  100325:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100328:	8d 45 0c             	lea    0xc(%ebp),%eax
  10032b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10032e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100331:	89 44 24 04          	mov    %eax,0x4(%esp)
  100335:	8b 45 08             	mov    0x8(%ebp),%eax
  100338:	89 04 24             	mov    %eax,(%esp)
  10033b:	e8 af ff ff ff       	call   1002ef <vcprintf>
  100340:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100343:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100346:	c9                   	leave  
  100347:	c3                   	ret    

00100348 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100348:	55                   	push   %ebp
  100349:	89 e5                	mov    %esp,%ebp
  10034b:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  10034e:	8b 45 08             	mov    0x8(%ebp),%eax
  100351:	89 04 24             	mov    %eax,(%esp)
  100354:	e8 48 12 00 00       	call   1015a1 <cons_putc>
}
  100359:	c9                   	leave  
  10035a:	c3                   	ret    

0010035b <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10035b:	55                   	push   %ebp
  10035c:	89 e5                	mov    %esp,%ebp
  10035e:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100361:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100368:	eb 13                	jmp    10037d <cputs+0x22>
        cputch(c, &cnt);
  10036a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10036e:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100371:	89 54 24 04          	mov    %edx,0x4(%esp)
  100375:	89 04 24             	mov    %eax,(%esp)
  100378:	e8 52 ff ff ff       	call   1002cf <cputch>
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  10037d:	8b 45 08             	mov    0x8(%ebp),%eax
  100380:	8d 50 01             	lea    0x1(%eax),%edx
  100383:	89 55 08             	mov    %edx,0x8(%ebp)
  100386:	0f b6 00             	movzbl (%eax),%eax
  100389:	88 45 f7             	mov    %al,-0x9(%ebp)
  10038c:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100390:	75 d8                	jne    10036a <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  100392:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100395:	89 44 24 04          	mov    %eax,0x4(%esp)
  100399:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  1003a0:	e8 2a ff ff ff       	call   1002cf <cputch>
    return cnt;
  1003a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1003a8:	c9                   	leave  
  1003a9:	c3                   	ret    

001003aa <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1003aa:	55                   	push   %ebp
  1003ab:	89 e5                	mov    %esp,%ebp
  1003ad:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1003b0:	e8 15 12 00 00       	call   1015ca <cons_getc>
  1003b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003b8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003bc:	74 f2                	je     1003b0 <getchar+0x6>
        /* do nothing */;
    return c;
  1003be:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003c1:	c9                   	leave  
  1003c2:	c3                   	ret    

001003c3 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1003c3:	55                   	push   %ebp
  1003c4:	89 e5                	mov    %esp,%ebp
  1003c6:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1003c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003cc:	8b 00                	mov    (%eax),%eax
  1003ce:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003d1:	8b 45 10             	mov    0x10(%ebp),%eax
  1003d4:	8b 00                	mov    (%eax),%eax
  1003d6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1003e0:	e9 d2 00 00 00       	jmp    1004b7 <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  1003e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1003e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1003eb:	01 d0                	add    %edx,%eax
  1003ed:	89 c2                	mov    %eax,%edx
  1003ef:	c1 ea 1f             	shr    $0x1f,%edx
  1003f2:	01 d0                	add    %edx,%eax
  1003f4:	d1 f8                	sar    %eax
  1003f6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1003f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1003fc:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1003ff:	eb 04                	jmp    100405 <stab_binsearch+0x42>
            m --;
  100401:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  100405:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100408:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  10040b:	7c 1f                	jl     10042c <stab_binsearch+0x69>
  10040d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100410:	89 d0                	mov    %edx,%eax
  100412:	01 c0                	add    %eax,%eax
  100414:	01 d0                	add    %edx,%eax
  100416:	c1 e0 02             	shl    $0x2,%eax
  100419:	89 c2                	mov    %eax,%edx
  10041b:	8b 45 08             	mov    0x8(%ebp),%eax
  10041e:	01 d0                	add    %edx,%eax
  100420:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100424:	0f b6 c0             	movzbl %al,%eax
  100427:	3b 45 14             	cmp    0x14(%ebp),%eax
  10042a:	75 d5                	jne    100401 <stab_binsearch+0x3e>
            m --;
        }
        if (m < l) {    // no match in [l, m]
  10042c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10042f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100432:	7d 0b                	jge    10043f <stab_binsearch+0x7c>
            l = true_m + 1;
  100434:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100437:	83 c0 01             	add    $0x1,%eax
  10043a:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10043d:	eb 78                	jmp    1004b7 <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  10043f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100446:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100449:	89 d0                	mov    %edx,%eax
  10044b:	01 c0                	add    %eax,%eax
  10044d:	01 d0                	add    %edx,%eax
  10044f:	c1 e0 02             	shl    $0x2,%eax
  100452:	89 c2                	mov    %eax,%edx
  100454:	8b 45 08             	mov    0x8(%ebp),%eax
  100457:	01 d0                	add    %edx,%eax
  100459:	8b 40 08             	mov    0x8(%eax),%eax
  10045c:	3b 45 18             	cmp    0x18(%ebp),%eax
  10045f:	73 13                	jae    100474 <stab_binsearch+0xb1>
            *region_left = m;
  100461:	8b 45 0c             	mov    0xc(%ebp),%eax
  100464:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100467:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100469:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10046c:	83 c0 01             	add    $0x1,%eax
  10046f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100472:	eb 43                	jmp    1004b7 <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  100474:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100477:	89 d0                	mov    %edx,%eax
  100479:	01 c0                	add    %eax,%eax
  10047b:	01 d0                	add    %edx,%eax
  10047d:	c1 e0 02             	shl    $0x2,%eax
  100480:	89 c2                	mov    %eax,%edx
  100482:	8b 45 08             	mov    0x8(%ebp),%eax
  100485:	01 d0                	add    %edx,%eax
  100487:	8b 40 08             	mov    0x8(%eax),%eax
  10048a:	3b 45 18             	cmp    0x18(%ebp),%eax
  10048d:	76 16                	jbe    1004a5 <stab_binsearch+0xe2>
            *region_right = m - 1;
  10048f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100492:	8d 50 ff             	lea    -0x1(%eax),%edx
  100495:	8b 45 10             	mov    0x10(%ebp),%eax
  100498:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  10049a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10049d:	83 e8 01             	sub    $0x1,%eax
  1004a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1004a3:	eb 12                	jmp    1004b7 <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  1004a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004ab:	89 10                	mov    %edx,(%eax)
            l = m;
  1004ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1004b3:	83 45 18 01          	addl   $0x1,0x18(%ebp)
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
  1004b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1004bd:	0f 8e 22 ff ff ff    	jle    1003e5 <stab_binsearch+0x22>
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
  1004c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004c7:	75 0f                	jne    1004d8 <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  1004c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004cc:	8b 00                	mov    (%eax),%eax
  1004ce:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004d1:	8b 45 10             	mov    0x10(%ebp),%eax
  1004d4:	89 10                	mov    %edx,(%eax)
  1004d6:	eb 3f                	jmp    100517 <stab_binsearch+0x154>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
  1004d8:	8b 45 10             	mov    0x10(%ebp),%eax
  1004db:	8b 00                	mov    (%eax),%eax
  1004dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1004e0:	eb 04                	jmp    1004e6 <stab_binsearch+0x123>
  1004e2:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1004e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004e9:	8b 00                	mov    (%eax),%eax
  1004eb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004ee:	7d 1f                	jge    10050f <stab_binsearch+0x14c>
  1004f0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004f3:	89 d0                	mov    %edx,%eax
  1004f5:	01 c0                	add    %eax,%eax
  1004f7:	01 d0                	add    %edx,%eax
  1004f9:	c1 e0 02             	shl    $0x2,%eax
  1004fc:	89 c2                	mov    %eax,%edx
  1004fe:	8b 45 08             	mov    0x8(%ebp),%eax
  100501:	01 d0                	add    %edx,%eax
  100503:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100507:	0f b6 c0             	movzbl %al,%eax
  10050a:	3b 45 14             	cmp    0x14(%ebp),%eax
  10050d:	75 d3                	jne    1004e2 <stab_binsearch+0x11f>
            /* do nothing */;
        *region_left = l;
  10050f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100512:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100515:	89 10                	mov    %edx,(%eax)
    }
}
  100517:	c9                   	leave  
  100518:	c3                   	ret    

00100519 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100519:	55                   	push   %ebp
  10051a:	89 e5                	mov    %esp,%ebp
  10051c:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10051f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100522:	c7 00 2c 36 10 00    	movl   $0x10362c,(%eax)
    info->eip_line = 0;
  100528:	8b 45 0c             	mov    0xc(%ebp),%eax
  10052b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100532:	8b 45 0c             	mov    0xc(%ebp),%eax
  100535:	c7 40 08 2c 36 10 00 	movl   $0x10362c,0x8(%eax)
    info->eip_fn_namelen = 9;
  10053c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10053f:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100546:	8b 45 0c             	mov    0xc(%ebp),%eax
  100549:	8b 55 08             	mov    0x8(%ebp),%edx
  10054c:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10054f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100552:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100559:	c7 45 f4 8c 3e 10 00 	movl   $0x103e8c,-0xc(%ebp)
    stab_end = __STAB_END__;
  100560:	c7 45 f0 98 b6 10 00 	movl   $0x10b698,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100567:	c7 45 ec 99 b6 10 00 	movl   $0x10b699,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10056e:	c7 45 e8 a8 d6 10 00 	movl   $0x10d6a8,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100575:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100578:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10057b:	76 0d                	jbe    10058a <debuginfo_eip+0x71>
  10057d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100580:	83 e8 01             	sub    $0x1,%eax
  100583:	0f b6 00             	movzbl (%eax),%eax
  100586:	84 c0                	test   %al,%al
  100588:	74 0a                	je     100594 <debuginfo_eip+0x7b>
        return -1;
  10058a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10058f:	e9 c0 02 00 00       	jmp    100854 <debuginfo_eip+0x33b>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100594:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10059b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10059e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005a1:	29 c2                	sub    %eax,%edx
  1005a3:	89 d0                	mov    %edx,%eax
  1005a5:	c1 f8 02             	sar    $0x2,%eax
  1005a8:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  1005ae:	83 e8 01             	sub    $0x1,%eax
  1005b1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1005b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1005b7:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005bb:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1005c2:	00 
  1005c3:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1005c6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005ca:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1005cd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1005d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005d4:	89 04 24             	mov    %eax,(%esp)
  1005d7:	e8 e7 fd ff ff       	call   1003c3 <stab_binsearch>
    if (lfile == 0)
  1005dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005df:	85 c0                	test   %eax,%eax
  1005e1:	75 0a                	jne    1005ed <debuginfo_eip+0xd4>
        return -1;
  1005e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005e8:	e9 67 02 00 00       	jmp    100854 <debuginfo_eip+0x33b>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1005ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005f0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1005f3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1005f6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1005f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1005fc:	89 44 24 10          	mov    %eax,0x10(%esp)
  100600:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  100607:	00 
  100608:	8d 45 d8             	lea    -0x28(%ebp),%eax
  10060b:	89 44 24 08          	mov    %eax,0x8(%esp)
  10060f:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100612:	89 44 24 04          	mov    %eax,0x4(%esp)
  100616:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100619:	89 04 24             	mov    %eax,(%esp)
  10061c:	e8 a2 fd ff ff       	call   1003c3 <stab_binsearch>

    if (lfun <= rfun) {
  100621:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100624:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100627:	39 c2                	cmp    %eax,%edx
  100629:	7f 7c                	jg     1006a7 <debuginfo_eip+0x18e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10062b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10062e:	89 c2                	mov    %eax,%edx
  100630:	89 d0                	mov    %edx,%eax
  100632:	01 c0                	add    %eax,%eax
  100634:	01 d0                	add    %edx,%eax
  100636:	c1 e0 02             	shl    $0x2,%eax
  100639:	89 c2                	mov    %eax,%edx
  10063b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10063e:	01 d0                	add    %edx,%eax
  100640:	8b 10                	mov    (%eax),%edx
  100642:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100645:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100648:	29 c1                	sub    %eax,%ecx
  10064a:	89 c8                	mov    %ecx,%eax
  10064c:	39 c2                	cmp    %eax,%edx
  10064e:	73 22                	jae    100672 <debuginfo_eip+0x159>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100650:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100653:	89 c2                	mov    %eax,%edx
  100655:	89 d0                	mov    %edx,%eax
  100657:	01 c0                	add    %eax,%eax
  100659:	01 d0                	add    %edx,%eax
  10065b:	c1 e0 02             	shl    $0x2,%eax
  10065e:	89 c2                	mov    %eax,%edx
  100660:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100663:	01 d0                	add    %edx,%eax
  100665:	8b 10                	mov    (%eax),%edx
  100667:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10066a:	01 c2                	add    %eax,%edx
  10066c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10066f:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100672:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100675:	89 c2                	mov    %eax,%edx
  100677:	89 d0                	mov    %edx,%eax
  100679:	01 c0                	add    %eax,%eax
  10067b:	01 d0                	add    %edx,%eax
  10067d:	c1 e0 02             	shl    $0x2,%eax
  100680:	89 c2                	mov    %eax,%edx
  100682:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100685:	01 d0                	add    %edx,%eax
  100687:	8b 50 08             	mov    0x8(%eax),%edx
  10068a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10068d:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100690:	8b 45 0c             	mov    0xc(%ebp),%eax
  100693:	8b 40 10             	mov    0x10(%eax),%eax
  100696:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100699:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10069c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  10069f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006a2:	89 45 d0             	mov    %eax,-0x30(%ebp)
  1006a5:	eb 15                	jmp    1006bc <debuginfo_eip+0x1a3>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  1006a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006aa:	8b 55 08             	mov    0x8(%ebp),%edx
  1006ad:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1006b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006b3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1006b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006b9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1006bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006bf:	8b 40 08             	mov    0x8(%eax),%eax
  1006c2:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1006c9:	00 
  1006ca:	89 04 24             	mov    %eax,(%esp)
  1006cd:	e8 8b 2b 00 00       	call   10325d <strfind>
  1006d2:	89 c2                	mov    %eax,%edx
  1006d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006d7:	8b 40 08             	mov    0x8(%eax),%eax
  1006da:	29 c2                	sub    %eax,%edx
  1006dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006df:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1006e2:	8b 45 08             	mov    0x8(%ebp),%eax
  1006e5:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006e9:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1006f0:	00 
  1006f1:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1006f4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006f8:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1006fb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100702:	89 04 24             	mov    %eax,(%esp)
  100705:	e8 b9 fc ff ff       	call   1003c3 <stab_binsearch>
    if (lline <= rline) {
  10070a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10070d:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100710:	39 c2                	cmp    %eax,%edx
  100712:	7f 24                	jg     100738 <debuginfo_eip+0x21f>
        info->eip_line = stabs[rline].n_desc;
  100714:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100717:	89 c2                	mov    %eax,%edx
  100719:	89 d0                	mov    %edx,%eax
  10071b:	01 c0                	add    %eax,%eax
  10071d:	01 d0                	add    %edx,%eax
  10071f:	c1 e0 02             	shl    $0x2,%eax
  100722:	89 c2                	mov    %eax,%edx
  100724:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100727:	01 d0                	add    %edx,%eax
  100729:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10072d:	0f b7 d0             	movzwl %ax,%edx
  100730:	8b 45 0c             	mov    0xc(%ebp),%eax
  100733:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100736:	eb 13                	jmp    10074b <debuginfo_eip+0x232>
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
  100738:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10073d:	e9 12 01 00 00       	jmp    100854 <debuginfo_eip+0x33b>
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100742:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100745:	83 e8 01             	sub    $0x1,%eax
  100748:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10074b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10074e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100751:	39 c2                	cmp    %eax,%edx
  100753:	7c 56                	jl     1007ab <debuginfo_eip+0x292>
           && stabs[lline].n_type != N_SOL
  100755:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100758:	89 c2                	mov    %eax,%edx
  10075a:	89 d0                	mov    %edx,%eax
  10075c:	01 c0                	add    %eax,%eax
  10075e:	01 d0                	add    %edx,%eax
  100760:	c1 e0 02             	shl    $0x2,%eax
  100763:	89 c2                	mov    %eax,%edx
  100765:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100768:	01 d0                	add    %edx,%eax
  10076a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10076e:	3c 84                	cmp    $0x84,%al
  100770:	74 39                	je     1007ab <debuginfo_eip+0x292>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100772:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100775:	89 c2                	mov    %eax,%edx
  100777:	89 d0                	mov    %edx,%eax
  100779:	01 c0                	add    %eax,%eax
  10077b:	01 d0                	add    %edx,%eax
  10077d:	c1 e0 02             	shl    $0x2,%eax
  100780:	89 c2                	mov    %eax,%edx
  100782:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100785:	01 d0                	add    %edx,%eax
  100787:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10078b:	3c 64                	cmp    $0x64,%al
  10078d:	75 b3                	jne    100742 <debuginfo_eip+0x229>
  10078f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100792:	89 c2                	mov    %eax,%edx
  100794:	89 d0                	mov    %edx,%eax
  100796:	01 c0                	add    %eax,%eax
  100798:	01 d0                	add    %edx,%eax
  10079a:	c1 e0 02             	shl    $0x2,%eax
  10079d:	89 c2                	mov    %eax,%edx
  10079f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007a2:	01 d0                	add    %edx,%eax
  1007a4:	8b 40 08             	mov    0x8(%eax),%eax
  1007a7:	85 c0                	test   %eax,%eax
  1007a9:	74 97                	je     100742 <debuginfo_eip+0x229>
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  1007ab:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007b1:	39 c2                	cmp    %eax,%edx
  1007b3:	7c 46                	jl     1007fb <debuginfo_eip+0x2e2>
  1007b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007b8:	89 c2                	mov    %eax,%edx
  1007ba:	89 d0                	mov    %edx,%eax
  1007bc:	01 c0                	add    %eax,%eax
  1007be:	01 d0                	add    %edx,%eax
  1007c0:	c1 e0 02             	shl    $0x2,%eax
  1007c3:	89 c2                	mov    %eax,%edx
  1007c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007c8:	01 d0                	add    %edx,%eax
  1007ca:	8b 10                	mov    (%eax),%edx
  1007cc:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1007cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007d2:	29 c1                	sub    %eax,%ecx
  1007d4:	89 c8                	mov    %ecx,%eax
  1007d6:	39 c2                	cmp    %eax,%edx
  1007d8:	73 21                	jae    1007fb <debuginfo_eip+0x2e2>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1007da:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007dd:	89 c2                	mov    %eax,%edx
  1007df:	89 d0                	mov    %edx,%eax
  1007e1:	01 c0                	add    %eax,%eax
  1007e3:	01 d0                	add    %edx,%eax
  1007e5:	c1 e0 02             	shl    $0x2,%eax
  1007e8:	89 c2                	mov    %eax,%edx
  1007ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007ed:	01 d0                	add    %edx,%eax
  1007ef:	8b 10                	mov    (%eax),%edx
  1007f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007f4:	01 c2                	add    %eax,%edx
  1007f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007f9:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1007fb:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1007fe:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100801:	39 c2                	cmp    %eax,%edx
  100803:	7d 4a                	jge    10084f <debuginfo_eip+0x336>
        for (lline = lfun + 1;
  100805:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100808:	83 c0 01             	add    $0x1,%eax
  10080b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  10080e:	eb 18                	jmp    100828 <debuginfo_eip+0x30f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100810:	8b 45 0c             	mov    0xc(%ebp),%eax
  100813:	8b 40 14             	mov    0x14(%eax),%eax
  100816:	8d 50 01             	lea    0x1(%eax),%edx
  100819:	8b 45 0c             	mov    0xc(%ebp),%eax
  10081c:	89 50 14             	mov    %edx,0x14(%eax)
    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
  10081f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100822:	83 c0 01             	add    $0x1,%eax
  100825:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100828:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10082b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
  10082e:	39 c2                	cmp    %eax,%edx
  100830:	7d 1d                	jge    10084f <debuginfo_eip+0x336>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100832:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100835:	89 c2                	mov    %eax,%edx
  100837:	89 d0                	mov    %edx,%eax
  100839:	01 c0                	add    %eax,%eax
  10083b:	01 d0                	add    %edx,%eax
  10083d:	c1 e0 02             	shl    $0x2,%eax
  100840:	89 c2                	mov    %eax,%edx
  100842:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100845:	01 d0                	add    %edx,%eax
  100847:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10084b:	3c a0                	cmp    $0xa0,%al
  10084d:	74 c1                	je     100810 <debuginfo_eip+0x2f7>
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
  10084f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100854:	c9                   	leave  
  100855:	c3                   	ret    

00100856 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100856:	55                   	push   %ebp
  100857:	89 e5                	mov    %esp,%ebp
  100859:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  10085c:	c7 04 24 36 36 10 00 	movl   $0x103636,(%esp)
  100863:	e8 ba fa ff ff       	call   100322 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100868:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10086f:	00 
  100870:	c7 04 24 4f 36 10 00 	movl   $0x10364f,(%esp)
  100877:	e8 a6 fa ff ff       	call   100322 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  10087c:	c7 44 24 04 72 35 10 	movl   $0x103572,0x4(%esp)
  100883:	00 
  100884:	c7 04 24 67 36 10 00 	movl   $0x103667,(%esp)
  10088b:	e8 92 fa ff ff       	call   100322 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100890:	c7 44 24 04 16 ea 10 	movl   $0x10ea16,0x4(%esp)
  100897:	00 
  100898:	c7 04 24 7f 36 10 00 	movl   $0x10367f,(%esp)
  10089f:	e8 7e fa ff ff       	call   100322 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1008a4:	c7 44 24 04 80 fd 10 	movl   $0x10fd80,0x4(%esp)
  1008ab:	00 
  1008ac:	c7 04 24 97 36 10 00 	movl   $0x103697,(%esp)
  1008b3:	e8 6a fa ff ff       	call   100322 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1008b8:	b8 80 fd 10 00       	mov    $0x10fd80,%eax
  1008bd:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008c3:	b8 00 00 10 00       	mov    $0x100000,%eax
  1008c8:	29 c2                	sub    %eax,%edx
  1008ca:	89 d0                	mov    %edx,%eax
  1008cc:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008d2:	85 c0                	test   %eax,%eax
  1008d4:	0f 48 c2             	cmovs  %edx,%eax
  1008d7:	c1 f8 0a             	sar    $0xa,%eax
  1008da:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008de:	c7 04 24 b0 36 10 00 	movl   $0x1036b0,(%esp)
  1008e5:	e8 38 fa ff ff       	call   100322 <cprintf>
}
  1008ea:	c9                   	leave  
  1008eb:	c3                   	ret    

001008ec <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1008ec:	55                   	push   %ebp
  1008ed:	89 e5                	mov    %esp,%ebp
  1008ef:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1008f5:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1008f8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008fc:	8b 45 08             	mov    0x8(%ebp),%eax
  1008ff:	89 04 24             	mov    %eax,(%esp)
  100902:	e8 12 fc ff ff       	call   100519 <debuginfo_eip>
  100907:	85 c0                	test   %eax,%eax
  100909:	74 15                	je     100920 <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  10090b:	8b 45 08             	mov    0x8(%ebp),%eax
  10090e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100912:	c7 04 24 da 36 10 00 	movl   $0x1036da,(%esp)
  100919:	e8 04 fa ff ff       	call   100322 <cprintf>
  10091e:	eb 6d                	jmp    10098d <print_debuginfo+0xa1>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100920:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100927:	eb 1c                	jmp    100945 <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  100929:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10092c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10092f:	01 d0                	add    %edx,%eax
  100931:	0f b6 00             	movzbl (%eax),%eax
  100934:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  10093a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10093d:	01 ca                	add    %ecx,%edx
  10093f:	88 02                	mov    %al,(%edx)
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100941:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100945:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100948:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  10094b:	7f dc                	jg     100929 <print_debuginfo+0x3d>
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
  10094d:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100953:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100956:	01 d0                	add    %edx,%eax
  100958:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
  10095b:	8b 45 ec             	mov    -0x14(%ebp),%eax
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  10095e:	8b 55 08             	mov    0x8(%ebp),%edx
  100961:	89 d1                	mov    %edx,%ecx
  100963:	29 c1                	sub    %eax,%ecx
  100965:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100968:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10096b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  10096f:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100975:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100979:	89 54 24 08          	mov    %edx,0x8(%esp)
  10097d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100981:	c7 04 24 f6 36 10 00 	movl   $0x1036f6,(%esp)
  100988:	e8 95 f9 ff ff       	call   100322 <cprintf>
                fnname, eip - info.eip_fn_addr);
    }
}
  10098d:	c9                   	leave  
  10098e:	c3                   	ret    

0010098f <read_eip>:

static __noinline uint32_t
read_eip(void) {
  10098f:	55                   	push   %ebp
  100990:	89 e5                	mov    %esp,%ebp
  100992:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100995:	8b 45 04             	mov    0x4(%ebp),%eax
  100998:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  10099b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10099e:	c9                   	leave  
  10099f:	c3                   	ret    

001009a0 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  1009a0:	55                   	push   %ebp
  1009a1:	89 e5                	mov    %esp,%ebp
  1009a3:	83 ec 38             	sub    $0x38,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  1009a6:	89 e8                	mov    %ebp,%eax
  1009a8:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return ebp;
  1009ab:	8b 45 e0             	mov    -0x20(%ebp),%eax
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp(), eip = read_eip();
  1009ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1009b1:	e8 d9 ff ff ff       	call   10098f <read_eip>
  1009b6:	89 45 f0             	mov    %eax,-0x10(%ebp)

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
  1009b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  1009c0:	e9 88 00 00 00       	jmp    100a4d <print_stackframe+0xad>
        cprintf("ebp:0x%08x eip:0x%08x args:", ebp, eip);
  1009c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1009c8:	89 44 24 08          	mov    %eax,0x8(%esp)
  1009cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009cf:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009d3:	c7 04 24 08 37 10 00 	movl   $0x103708,(%esp)
  1009da:	e8 43 f9 ff ff       	call   100322 <cprintf>
        uint32_t *args = (uint32_t *)ebp + 2;
  1009df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009e2:	83 c0 08             	add    $0x8,%eax
  1009e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        for (j = 0; j < 4; j ++) {
  1009e8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  1009ef:	eb 25                	jmp    100a16 <print_stackframe+0x76>
            cprintf("0x%08x ", args[j]);
  1009f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1009f4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  1009fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1009fe:	01 d0                	add    %edx,%eax
  100a00:	8b 00                	mov    (%eax),%eax
  100a02:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a06:	c7 04 24 24 37 10 00 	movl   $0x103724,(%esp)
  100a0d:	e8 10 f9 ff ff       	call   100322 <cprintf>

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
        cprintf("ebp:0x%08x eip:0x%08x args:", ebp, eip);
        uint32_t *args = (uint32_t *)ebp + 2;
        for (j = 0; j < 4; j ++) {
  100a12:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
  100a16:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
  100a1a:	7e d5                	jle    1009f1 <print_stackframe+0x51>
            cprintf("0x%08x ", args[j]);
        }
        cprintf("\n");
  100a1c:	c7 04 24 2c 37 10 00 	movl   $0x10372c,(%esp)
  100a23:	e8 fa f8 ff ff       	call   100322 <cprintf>
        print_debuginfo(eip - 1);
  100a28:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a2b:	83 e8 01             	sub    $0x1,%eax
  100a2e:	89 04 24             	mov    %eax,(%esp)
  100a31:	e8 b6 fe ff ff       	call   1008ec <print_debuginfo>
        eip = ((uint32_t *)ebp)[1];
  100a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a39:	83 c0 04             	add    $0x4,%eax
  100a3c:	8b 00                	mov    (%eax),%eax
  100a3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = ((uint32_t *)ebp)[0];
  100a41:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a44:	8b 00                	mov    (%eax),%eax
  100a46:	89 45 f4             	mov    %eax,-0xc(%ebp)
      *                   the calling funciton's ebp = ss:[ebp]
      */
    uint32_t ebp = read_ebp(), eip = read_eip();

    int i, j;
    for (i = 0; ebp != 0 && i < STACKFRAME_DEPTH; i ++) {
  100a49:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100a4d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100a51:	74 0a                	je     100a5d <print_stackframe+0xbd>
  100a53:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100a57:	0f 8e 68 ff ff ff    	jle    1009c5 <print_stackframe+0x25>
        cprintf("\n");
        print_debuginfo(eip - 1);
        eip = ((uint32_t *)ebp)[1];
        ebp = ((uint32_t *)ebp)[0];
    }
}
  100a5d:	c9                   	leave  
  100a5e:	c3                   	ret    

00100a5f <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100a5f:	55                   	push   %ebp
  100a60:	89 e5                	mov    %esp,%ebp
  100a62:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100a65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100a6c:	eb 0c                	jmp    100a7a <parse+0x1b>
            *buf ++ = '\0';
  100a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  100a71:	8d 50 01             	lea    0x1(%eax),%edx
  100a74:	89 55 08             	mov    %edx,0x8(%ebp)
  100a77:	c6 00 00             	movb   $0x0,(%eax)
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  100a7d:	0f b6 00             	movzbl (%eax),%eax
  100a80:	84 c0                	test   %al,%al
  100a82:	74 1d                	je     100aa1 <parse+0x42>
  100a84:	8b 45 08             	mov    0x8(%ebp),%eax
  100a87:	0f b6 00             	movzbl (%eax),%eax
  100a8a:	0f be c0             	movsbl %al,%eax
  100a8d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a91:	c7 04 24 b0 37 10 00 	movl   $0x1037b0,(%esp)
  100a98:	e8 8d 27 00 00       	call   10322a <strchr>
  100a9d:	85 c0                	test   %eax,%eax
  100a9f:	75 cd                	jne    100a6e <parse+0xf>
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
  100aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  100aa4:	0f b6 00             	movzbl (%eax),%eax
  100aa7:	84 c0                	test   %al,%al
  100aa9:	75 02                	jne    100aad <parse+0x4e>
            break;
  100aab:	eb 67                	jmp    100b14 <parse+0xb5>
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100aad:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100ab1:	75 14                	jne    100ac7 <parse+0x68>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100ab3:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100aba:	00 
  100abb:	c7 04 24 b5 37 10 00 	movl   $0x1037b5,(%esp)
  100ac2:	e8 5b f8 ff ff       	call   100322 <cprintf>
        }
        argv[argc ++] = buf;
  100ac7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100aca:	8d 50 01             	lea    0x1(%eax),%edx
  100acd:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100ad0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100ad7:	8b 45 0c             	mov    0xc(%ebp),%eax
  100ada:	01 c2                	add    %eax,%edx
  100adc:	8b 45 08             	mov    0x8(%ebp),%eax
  100adf:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100ae1:	eb 04                	jmp    100ae7 <parse+0x88>
            buf ++;
  100ae3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        // save and scan past next arg
        if (argc == MAXARGS - 1) {
            cprintf("Too many arguments (max %d).\n", MAXARGS);
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  100aea:	0f b6 00             	movzbl (%eax),%eax
  100aed:	84 c0                	test   %al,%al
  100aef:	74 1d                	je     100b0e <parse+0xaf>
  100af1:	8b 45 08             	mov    0x8(%ebp),%eax
  100af4:	0f b6 00             	movzbl (%eax),%eax
  100af7:	0f be c0             	movsbl %al,%eax
  100afa:	89 44 24 04          	mov    %eax,0x4(%esp)
  100afe:	c7 04 24 b0 37 10 00 	movl   $0x1037b0,(%esp)
  100b05:	e8 20 27 00 00       	call   10322a <strchr>
  100b0a:	85 c0                	test   %eax,%eax
  100b0c:	74 d5                	je     100ae3 <parse+0x84>
            buf ++;
        }
    }
  100b0e:	90                   	nop
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b0f:	e9 66 ff ff ff       	jmp    100a7a <parse+0x1b>
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
            buf ++;
        }
    }
    return argc;
  100b14:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100b17:	c9                   	leave  
  100b18:	c3                   	ret    

00100b19 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100b19:	55                   	push   %ebp
  100b1a:	89 e5                	mov    %esp,%ebp
  100b1c:	83 ec 68             	sub    $0x68,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100b1f:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100b22:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b26:	8b 45 08             	mov    0x8(%ebp),%eax
  100b29:	89 04 24             	mov    %eax,(%esp)
  100b2c:	e8 2e ff ff ff       	call   100a5f <parse>
  100b31:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100b34:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100b38:	75 0a                	jne    100b44 <runcmd+0x2b>
        return 0;
  100b3a:	b8 00 00 00 00       	mov    $0x0,%eax
  100b3f:	e9 85 00 00 00       	jmp    100bc9 <runcmd+0xb0>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100b44:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b4b:	eb 5c                	jmp    100ba9 <runcmd+0x90>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100b4d:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100b50:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b53:	89 d0                	mov    %edx,%eax
  100b55:	01 c0                	add    %eax,%eax
  100b57:	01 d0                	add    %edx,%eax
  100b59:	c1 e0 02             	shl    $0x2,%eax
  100b5c:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b61:	8b 00                	mov    (%eax),%eax
  100b63:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100b67:	89 04 24             	mov    %eax,(%esp)
  100b6a:	e8 1c 26 00 00       	call   10318b <strcmp>
  100b6f:	85 c0                	test   %eax,%eax
  100b71:	75 32                	jne    100ba5 <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100b73:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b76:	89 d0                	mov    %edx,%eax
  100b78:	01 c0                	add    %eax,%eax
  100b7a:	01 d0                	add    %edx,%eax
  100b7c:	c1 e0 02             	shl    $0x2,%eax
  100b7f:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b84:	8b 40 08             	mov    0x8(%eax),%eax
  100b87:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100b8a:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100b8d:	8b 55 0c             	mov    0xc(%ebp),%edx
  100b90:	89 54 24 08          	mov    %edx,0x8(%esp)
  100b94:	8d 55 b0             	lea    -0x50(%ebp),%edx
  100b97:	83 c2 04             	add    $0x4,%edx
  100b9a:	89 54 24 04          	mov    %edx,0x4(%esp)
  100b9e:	89 0c 24             	mov    %ecx,(%esp)
  100ba1:	ff d0                	call   *%eax
  100ba3:	eb 24                	jmp    100bc9 <runcmd+0xb0>
    int argc = parse(buf, argv);
    if (argc == 0) {
        return 0;
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100ba5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100ba9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bac:	83 f8 02             	cmp    $0x2,%eax
  100baf:	76 9c                	jbe    100b4d <runcmd+0x34>
        if (strcmp(commands[i].name, argv[0]) == 0) {
            return commands[i].func(argc - 1, argv + 1, tf);
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100bb1:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100bb4:	89 44 24 04          	mov    %eax,0x4(%esp)
  100bb8:	c7 04 24 d3 37 10 00 	movl   $0x1037d3,(%esp)
  100bbf:	e8 5e f7 ff ff       	call   100322 <cprintf>
    return 0;
  100bc4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100bc9:	c9                   	leave  
  100bca:	c3                   	ret    

00100bcb <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100bcb:	55                   	push   %ebp
  100bcc:	89 e5                	mov    %esp,%ebp
  100bce:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100bd1:	c7 04 24 ec 37 10 00 	movl   $0x1037ec,(%esp)
  100bd8:	e8 45 f7 ff ff       	call   100322 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100bdd:	c7 04 24 14 38 10 00 	movl   $0x103814,(%esp)
  100be4:	e8 39 f7 ff ff       	call   100322 <cprintf>

    if (tf != NULL) {
  100be9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100bed:	74 0b                	je     100bfa <kmonitor+0x2f>
        print_trapframe(tf);
  100bef:	8b 45 08             	mov    0x8(%ebp),%eax
  100bf2:	89 04 24             	mov    %eax,(%esp)
  100bf5:	e8 cd 0d 00 00       	call   1019c7 <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100bfa:	c7 04 24 39 38 10 00 	movl   $0x103839,(%esp)
  100c01:	e8 13 f6 ff ff       	call   100219 <readline>
  100c06:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c09:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c0d:	74 18                	je     100c27 <kmonitor+0x5c>
            if (runcmd(buf, tf) < 0) {
  100c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  100c12:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c16:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c19:	89 04 24             	mov    %eax,(%esp)
  100c1c:	e8 f8 fe ff ff       	call   100b19 <runcmd>
  100c21:	85 c0                	test   %eax,%eax
  100c23:	79 02                	jns    100c27 <kmonitor+0x5c>
                break;
  100c25:	eb 02                	jmp    100c29 <kmonitor+0x5e>
            }
        }
    }
  100c27:	eb d1                	jmp    100bfa <kmonitor+0x2f>
}
  100c29:	c9                   	leave  
  100c2a:	c3                   	ret    

00100c2b <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100c2b:	55                   	push   %ebp
  100c2c:	89 e5                	mov    %esp,%ebp
  100c2e:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c31:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c38:	eb 3f                	jmp    100c79 <mon_help+0x4e>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100c3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c3d:	89 d0                	mov    %edx,%eax
  100c3f:	01 c0                	add    %eax,%eax
  100c41:	01 d0                	add    %edx,%eax
  100c43:	c1 e0 02             	shl    $0x2,%eax
  100c46:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c4b:	8b 48 04             	mov    0x4(%eax),%ecx
  100c4e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c51:	89 d0                	mov    %edx,%eax
  100c53:	01 c0                	add    %eax,%eax
  100c55:	01 d0                	add    %edx,%eax
  100c57:	c1 e0 02             	shl    $0x2,%eax
  100c5a:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c5f:	8b 00                	mov    (%eax),%eax
  100c61:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100c65:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c69:	c7 04 24 3d 38 10 00 	movl   $0x10383d,(%esp)
  100c70:	e8 ad f6 ff ff       	call   100322 <cprintf>

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c75:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100c79:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c7c:	83 f8 02             	cmp    $0x2,%eax
  100c7f:	76 b9                	jbe    100c3a <mon_help+0xf>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
    }
    return 0;
  100c81:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c86:	c9                   	leave  
  100c87:	c3                   	ret    

00100c88 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100c88:	55                   	push   %ebp
  100c89:	89 e5                	mov    %esp,%ebp
  100c8b:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100c8e:	e8 c3 fb ff ff       	call   100856 <print_kerninfo>
    return 0;
  100c93:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c98:	c9                   	leave  
  100c99:	c3                   	ret    

00100c9a <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100c9a:	55                   	push   %ebp
  100c9b:	89 e5                	mov    %esp,%ebp
  100c9d:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100ca0:	e8 fb fc ff ff       	call   1009a0 <print_stackframe>
    return 0;
  100ca5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100caa:	c9                   	leave  
  100cab:	c3                   	ret    

00100cac <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100cac:	55                   	push   %ebp
  100cad:	89 e5                	mov    %esp,%ebp
  100caf:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100cb2:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  100cb7:	85 c0                	test   %eax,%eax
  100cb9:	74 02                	je     100cbd <__panic+0x11>
        goto panic_dead;
  100cbb:	eb 48                	jmp    100d05 <__panic+0x59>
    }
    is_panic = 1;
  100cbd:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  100cc4:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100cc7:	8d 45 14             	lea    0x14(%ebp),%eax
  100cca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100ccd:	8b 45 0c             	mov    0xc(%ebp),%eax
  100cd0:	89 44 24 08          	mov    %eax,0x8(%esp)
  100cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  100cd7:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cdb:	c7 04 24 46 38 10 00 	movl   $0x103846,(%esp)
  100ce2:	e8 3b f6 ff ff       	call   100322 <cprintf>
    vcprintf(fmt, ap);
  100ce7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cea:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cee:	8b 45 10             	mov    0x10(%ebp),%eax
  100cf1:	89 04 24             	mov    %eax,(%esp)
  100cf4:	e8 f6 f5 ff ff       	call   1002ef <vcprintf>
    cprintf("\n");
  100cf9:	c7 04 24 62 38 10 00 	movl   $0x103862,(%esp)
  100d00:	e8 1d f6 ff ff       	call   100322 <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
  100d05:	e8 22 09 00 00       	call   10162c <intr_disable>
    while (1) {
        kmonitor(NULL);
  100d0a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100d11:	e8 b5 fe ff ff       	call   100bcb <kmonitor>
    }
  100d16:	eb f2                	jmp    100d0a <__panic+0x5e>

00100d18 <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100d18:	55                   	push   %ebp
  100d19:	89 e5                	mov    %esp,%ebp
  100d1b:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100d1e:	8d 45 14             	lea    0x14(%ebp),%eax
  100d21:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100d24:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d27:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  100d2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d32:	c7 04 24 64 38 10 00 	movl   $0x103864,(%esp)
  100d39:	e8 e4 f5 ff ff       	call   100322 <cprintf>
    vcprintf(fmt, ap);
  100d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d41:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d45:	8b 45 10             	mov    0x10(%ebp),%eax
  100d48:	89 04 24             	mov    %eax,(%esp)
  100d4b:	e8 9f f5 ff ff       	call   1002ef <vcprintf>
    cprintf("\n");
  100d50:	c7 04 24 62 38 10 00 	movl   $0x103862,(%esp)
  100d57:	e8 c6 f5 ff ff       	call   100322 <cprintf>
    va_end(ap);
}
  100d5c:	c9                   	leave  
  100d5d:	c3                   	ret    

00100d5e <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100d5e:	55                   	push   %ebp
  100d5f:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100d61:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  100d66:	5d                   	pop    %ebp
  100d67:	c3                   	ret    

00100d68 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100d68:	55                   	push   %ebp
  100d69:	89 e5                	mov    %esp,%ebp
  100d6b:	83 ec 28             	sub    $0x28,%esp
  100d6e:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100d74:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100d78:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100d7c:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100d80:	ee                   	out    %al,(%dx)
  100d81:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100d87:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100d8b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100d8f:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100d93:	ee                   	out    %al,(%dx)
  100d94:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
  100d9a:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
  100d9e:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100da2:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100da6:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100da7:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100dae:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100db1:	c7 04 24 82 38 10 00 	movl   $0x103882,(%esp)
  100db8:	e8 65 f5 ff ff       	call   100322 <cprintf>
    pic_enable(IRQ_TIMER);
  100dbd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100dc4:	e8 c1 08 00 00       	call   10168a <pic_enable>
}
  100dc9:	c9                   	leave  
  100dca:	c3                   	ret    

00100dcb <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100dcb:	55                   	push   %ebp
  100dcc:	89 e5                	mov    %esp,%ebp
  100dce:	83 ec 10             	sub    $0x10,%esp
  100dd1:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100dd7:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100ddb:	89 c2                	mov    %eax,%edx
  100ddd:	ec                   	in     (%dx),%al
  100dde:	88 45 fd             	mov    %al,-0x3(%ebp)
  100de1:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100de7:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100deb:	89 c2                	mov    %eax,%edx
  100ded:	ec                   	in     (%dx),%al
  100dee:	88 45 f9             	mov    %al,-0x7(%ebp)
  100df1:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100df7:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100dfb:	89 c2                	mov    %eax,%edx
  100dfd:	ec                   	in     (%dx),%al
  100dfe:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e01:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
  100e07:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e0b:	89 c2                	mov    %eax,%edx
  100e0d:	ec                   	in     (%dx),%al
  100e0e:	88 45 f1             	mov    %al,-0xf(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e11:	c9                   	leave  
  100e12:	c3                   	ret    

00100e13 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  100e13:	55                   	push   %ebp
  100e14:	89 e5                	mov    %esp,%ebp
  100e16:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;
  100e19:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;
  100e20:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e23:	0f b7 00             	movzwl (%eax),%eax
  100e26:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  100e2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e2d:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  100e32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e35:	0f b7 00             	movzwl (%eax),%eax
  100e38:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100e3c:	74 12                	je     100e50 <cga_init+0x3d>
        cp = (uint16_t*)MONO_BUF;
  100e3e:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  100e45:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100e4c:	b4 03 
  100e4e:	eb 13                	jmp    100e63 <cga_init+0x50>
    } else {
        *cp = was;
  100e50:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e53:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100e57:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  100e5a:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100e61:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  100e63:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e6a:	0f b7 c0             	movzwl %ax,%eax
  100e6d:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100e71:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e75:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100e79:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100e7d:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
  100e7e:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e85:	83 c0 01             	add    $0x1,%eax
  100e88:	0f b7 c0             	movzwl %ax,%eax
  100e8b:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e8f:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100e93:	89 c2                	mov    %eax,%edx
  100e95:	ec                   	in     (%dx),%al
  100e96:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100e99:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100e9d:	0f b6 c0             	movzbl %al,%eax
  100ea0:	c1 e0 08             	shl    $0x8,%eax
  100ea3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100ea6:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100ead:	0f b7 c0             	movzwl %ax,%eax
  100eb0:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  100eb4:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100eb8:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100ebc:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100ec0:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
  100ec1:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100ec8:	83 c0 01             	add    $0x1,%eax
  100ecb:	0f b7 c0             	movzwl %ax,%eax
  100ece:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ed2:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
  100ed6:	89 c2                	mov    %eax,%edx
  100ed8:	ec                   	in     (%dx),%al
  100ed9:	88 45 e5             	mov    %al,-0x1b(%ebp)
    return data;
  100edc:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100ee0:	0f b6 c0             	movzbl %al,%eax
  100ee3:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  100ee6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100ee9:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;
  100eee:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ef1:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100ef7:	c9                   	leave  
  100ef8:	c3                   	ret    

00100ef9 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100ef9:	55                   	push   %ebp
  100efa:	89 e5                	mov    %esp,%ebp
  100efc:	83 ec 48             	sub    $0x48,%esp
  100eff:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100f05:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f09:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f0d:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f11:	ee                   	out    %al,(%dx)
  100f12:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
  100f18:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
  100f1c:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f20:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f24:	ee                   	out    %al,(%dx)
  100f25:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
  100f2b:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
  100f2f:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f33:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f37:	ee                   	out    %al,(%dx)
  100f38:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100f3e:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
  100f42:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f46:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100f4a:	ee                   	out    %al,(%dx)
  100f4b:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
  100f51:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
  100f55:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f59:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100f5d:	ee                   	out    %al,(%dx)
  100f5e:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
  100f64:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  100f68:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100f6c:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100f70:	ee                   	out    %al,(%dx)
  100f71:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100f77:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
  100f7b:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100f7f:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100f83:	ee                   	out    %al,(%dx)
  100f84:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f8a:	0f b7 45 da          	movzwl -0x26(%ebp),%eax
  100f8e:	89 c2                	mov    %eax,%edx
  100f90:	ec                   	in     (%dx),%al
  100f91:	88 45 d9             	mov    %al,-0x27(%ebp)
    return data;
  100f94:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100f98:	3c ff                	cmp    $0xff,%al
  100f9a:	0f 95 c0             	setne  %al
  100f9d:	0f b6 c0             	movzbl %al,%eax
  100fa0:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  100fa5:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fab:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  100faf:	89 c2                	mov    %eax,%edx
  100fb1:	ec                   	in     (%dx),%al
  100fb2:	88 45 d5             	mov    %al,-0x2b(%ebp)
  100fb5:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
  100fbb:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
  100fbf:	89 c2                	mov    %eax,%edx
  100fc1:	ec                   	in     (%dx),%al
  100fc2:	88 45 d1             	mov    %al,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  100fc5:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  100fca:	85 c0                	test   %eax,%eax
  100fcc:	74 0c                	je     100fda <serial_init+0xe1>
        pic_enable(IRQ_COM1);
  100fce:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  100fd5:	e8 b0 06 00 00       	call   10168a <pic_enable>
    }
}
  100fda:	c9                   	leave  
  100fdb:	c3                   	ret    

00100fdc <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  100fdc:	55                   	push   %ebp
  100fdd:	89 e5                	mov    %esp,%ebp
  100fdf:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100fe2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100fe9:	eb 09                	jmp    100ff4 <lpt_putc_sub+0x18>
        delay();
  100feb:	e8 db fd ff ff       	call   100dcb <delay>
}

static void
lpt_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100ff0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100ff4:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  100ffa:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100ffe:	89 c2                	mov    %eax,%edx
  101000:	ec                   	in     (%dx),%al
  101001:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101004:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101008:	84 c0                	test   %al,%al
  10100a:	78 09                	js     101015 <lpt_putc_sub+0x39>
  10100c:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101013:	7e d6                	jle    100feb <lpt_putc_sub+0xf>
        delay();
    }
    outb(LPTPORT + 0, c);
  101015:	8b 45 08             	mov    0x8(%ebp),%eax
  101018:	0f b6 c0             	movzbl %al,%eax
  10101b:	66 c7 45 f6 78 03    	movw   $0x378,-0xa(%ebp)
  101021:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101024:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101028:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10102c:	ee                   	out    %al,(%dx)
  10102d:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101033:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  101037:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10103b:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10103f:	ee                   	out    %al,(%dx)
  101040:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
  101046:	c6 45 ed 08          	movb   $0x8,-0x13(%ebp)
  10104a:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10104e:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101052:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  101053:	c9                   	leave  
  101054:	c3                   	ret    

00101055 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  101055:	55                   	push   %ebp
  101056:	89 e5                	mov    %esp,%ebp
  101058:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  10105b:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10105f:	74 0d                	je     10106e <lpt_putc+0x19>
        lpt_putc_sub(c);
  101061:	8b 45 08             	mov    0x8(%ebp),%eax
  101064:	89 04 24             	mov    %eax,(%esp)
  101067:	e8 70 ff ff ff       	call   100fdc <lpt_putc_sub>
  10106c:	eb 24                	jmp    101092 <lpt_putc+0x3d>
    }
    else {
        lpt_putc_sub('\b');
  10106e:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101075:	e8 62 ff ff ff       	call   100fdc <lpt_putc_sub>
        lpt_putc_sub(' ');
  10107a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  101081:	e8 56 ff ff ff       	call   100fdc <lpt_putc_sub>
        lpt_putc_sub('\b');
  101086:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10108d:	e8 4a ff ff ff       	call   100fdc <lpt_putc_sub>
    }
}
  101092:	c9                   	leave  
  101093:	c3                   	ret    

00101094 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101094:	55                   	push   %ebp
  101095:	89 e5                	mov    %esp,%ebp
  101097:	53                   	push   %ebx
  101098:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  10109b:	8b 45 08             	mov    0x8(%ebp),%eax
  10109e:	b0 00                	mov    $0x0,%al
  1010a0:	85 c0                	test   %eax,%eax
  1010a2:	75 07                	jne    1010ab <cga_putc+0x17>
        c |= 0x0700;
  1010a4:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  1010ab:	8b 45 08             	mov    0x8(%ebp),%eax
  1010ae:	0f b6 c0             	movzbl %al,%eax
  1010b1:	83 f8 0a             	cmp    $0xa,%eax
  1010b4:	74 4c                	je     101102 <cga_putc+0x6e>
  1010b6:	83 f8 0d             	cmp    $0xd,%eax
  1010b9:	74 57                	je     101112 <cga_putc+0x7e>
  1010bb:	83 f8 08             	cmp    $0x8,%eax
  1010be:	0f 85 88 00 00 00    	jne    10114c <cga_putc+0xb8>
    case '\b':
        if (crt_pos > 0) {
  1010c4:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010cb:	66 85 c0             	test   %ax,%ax
  1010ce:	74 30                	je     101100 <cga_putc+0x6c>
            crt_pos --;
  1010d0:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010d7:	83 e8 01             	sub    $0x1,%eax
  1010da:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  1010e0:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1010e5:	0f b7 15 64 ee 10 00 	movzwl 0x10ee64,%edx
  1010ec:	0f b7 d2             	movzwl %dx,%edx
  1010ef:	01 d2                	add    %edx,%edx
  1010f1:	01 c2                	add    %eax,%edx
  1010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1010f6:	b0 00                	mov    $0x0,%al
  1010f8:	83 c8 20             	or     $0x20,%eax
  1010fb:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  1010fe:	eb 72                	jmp    101172 <cga_putc+0xde>
  101100:	eb 70                	jmp    101172 <cga_putc+0xde>
    case '\n':
        crt_pos += CRT_COLS;
  101102:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101109:	83 c0 50             	add    $0x50,%eax
  10110c:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101112:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  101119:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  101120:	0f b7 c1             	movzwl %cx,%eax
  101123:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  101129:	c1 e8 10             	shr    $0x10,%eax
  10112c:	89 c2                	mov    %eax,%edx
  10112e:	66 c1 ea 06          	shr    $0x6,%dx
  101132:	89 d0                	mov    %edx,%eax
  101134:	c1 e0 02             	shl    $0x2,%eax
  101137:	01 d0                	add    %edx,%eax
  101139:	c1 e0 04             	shl    $0x4,%eax
  10113c:	29 c1                	sub    %eax,%ecx
  10113e:	89 ca                	mov    %ecx,%edx
  101140:	89 d8                	mov    %ebx,%eax
  101142:	29 d0                	sub    %edx,%eax
  101144:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  10114a:	eb 26                	jmp    101172 <cga_putc+0xde>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  10114c:	8b 0d 60 ee 10 00    	mov    0x10ee60,%ecx
  101152:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101159:	8d 50 01             	lea    0x1(%eax),%edx
  10115c:	66 89 15 64 ee 10 00 	mov    %dx,0x10ee64
  101163:	0f b7 c0             	movzwl %ax,%eax
  101166:	01 c0                	add    %eax,%eax
  101168:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  10116b:	8b 45 08             	mov    0x8(%ebp),%eax
  10116e:	66 89 02             	mov    %ax,(%edx)
        break;
  101171:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101172:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101179:	66 3d cf 07          	cmp    $0x7cf,%ax
  10117d:	76 5b                	jbe    1011da <cga_putc+0x146>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  10117f:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101184:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  10118a:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  10118f:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  101196:	00 
  101197:	89 54 24 04          	mov    %edx,0x4(%esp)
  10119b:	89 04 24             	mov    %eax,(%esp)
  10119e:	e8 85 22 00 00       	call   103428 <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1011a3:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  1011aa:	eb 15                	jmp    1011c1 <cga_putc+0x12d>
            crt_buf[i] = 0x0700 | ' ';
  1011ac:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1011b4:	01 d2                	add    %edx,%edx
  1011b6:	01 d0                	add    %edx,%eax
  1011b8:	66 c7 00 20 07       	movw   $0x720,(%eax)

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1011bd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1011c1:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  1011c8:	7e e2                	jle    1011ac <cga_putc+0x118>
            crt_buf[i] = 0x0700 | ' ';
        }
        crt_pos -= CRT_COLS;
  1011ca:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011d1:	83 e8 50             	sub    $0x50,%eax
  1011d4:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  1011da:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  1011e1:	0f b7 c0             	movzwl %ax,%eax
  1011e4:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  1011e8:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
  1011ec:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  1011f0:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1011f4:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  1011f5:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011fc:	66 c1 e8 08          	shr    $0x8,%ax
  101200:	0f b6 c0             	movzbl %al,%eax
  101203:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10120a:	83 c2 01             	add    $0x1,%edx
  10120d:	0f b7 d2             	movzwl %dx,%edx
  101210:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
  101214:	88 45 ed             	mov    %al,-0x13(%ebp)
  101217:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10121b:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10121f:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  101220:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101227:	0f b7 c0             	movzwl %ax,%eax
  10122a:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  10122e:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
  101232:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101236:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  10123a:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  10123b:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101242:	0f b6 c0             	movzbl %al,%eax
  101245:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10124c:	83 c2 01             	add    $0x1,%edx
  10124f:	0f b7 d2             	movzwl %dx,%edx
  101252:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  101256:	88 45 e5             	mov    %al,-0x1b(%ebp)
  101259:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10125d:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  101261:	ee                   	out    %al,(%dx)
}
  101262:	83 c4 34             	add    $0x34,%esp
  101265:	5b                   	pop    %ebx
  101266:	5d                   	pop    %ebp
  101267:	c3                   	ret    

00101268 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101268:	55                   	push   %ebp
  101269:	89 e5                	mov    %esp,%ebp
  10126b:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10126e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101275:	eb 09                	jmp    101280 <serial_putc_sub+0x18>
        delay();
  101277:	e8 4f fb ff ff       	call   100dcb <delay>
}

static void
serial_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10127c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101280:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101286:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10128a:	89 c2                	mov    %eax,%edx
  10128c:	ec                   	in     (%dx),%al
  10128d:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101290:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101294:	0f b6 c0             	movzbl %al,%eax
  101297:	83 e0 20             	and    $0x20,%eax
  10129a:	85 c0                	test   %eax,%eax
  10129c:	75 09                	jne    1012a7 <serial_putc_sub+0x3f>
  10129e:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1012a5:	7e d0                	jle    101277 <serial_putc_sub+0xf>
        delay();
    }
    outb(COM1 + COM_TX, c);
  1012a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1012aa:	0f b6 c0             	movzbl %al,%eax
  1012ad:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1012b3:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012b6:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1012ba:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1012be:	ee                   	out    %al,(%dx)
}
  1012bf:	c9                   	leave  
  1012c0:	c3                   	ret    

001012c1 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1012c1:	55                   	push   %ebp
  1012c2:	89 e5                	mov    %esp,%ebp
  1012c4:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1012c7:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1012cb:	74 0d                	je     1012da <serial_putc+0x19>
        serial_putc_sub(c);
  1012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1012d0:	89 04 24             	mov    %eax,(%esp)
  1012d3:	e8 90 ff ff ff       	call   101268 <serial_putc_sub>
  1012d8:	eb 24                	jmp    1012fe <serial_putc+0x3d>
    }
    else {
        serial_putc_sub('\b');
  1012da:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1012e1:	e8 82 ff ff ff       	call   101268 <serial_putc_sub>
        serial_putc_sub(' ');
  1012e6:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1012ed:	e8 76 ff ff ff       	call   101268 <serial_putc_sub>
        serial_putc_sub('\b');
  1012f2:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1012f9:	e8 6a ff ff ff       	call   101268 <serial_putc_sub>
    }
}
  1012fe:	c9                   	leave  
  1012ff:	c3                   	ret    

00101300 <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  101300:	55                   	push   %ebp
  101301:	89 e5                	mov    %esp,%ebp
  101303:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  101306:	eb 33                	jmp    10133b <cons_intr+0x3b>
        if (c != 0) {
  101308:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10130c:	74 2d                	je     10133b <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  10130e:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101313:	8d 50 01             	lea    0x1(%eax),%edx
  101316:	89 15 84 f0 10 00    	mov    %edx,0x10f084
  10131c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10131f:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  101325:	a1 84 f0 10 00       	mov    0x10f084,%eax
  10132a:	3d 00 02 00 00       	cmp    $0x200,%eax
  10132f:	75 0a                	jne    10133b <cons_intr+0x3b>
                cons.wpos = 0;
  101331:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  101338:	00 00 00 
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
    int c;
    while ((c = (*proc)()) != -1) {
  10133b:	8b 45 08             	mov    0x8(%ebp),%eax
  10133e:	ff d0                	call   *%eax
  101340:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101343:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101347:	75 bf                	jne    101308 <cons_intr+0x8>
            if (cons.wpos == CONSBUFSIZE) {
                cons.wpos = 0;
            }
        }
    }
}
  101349:	c9                   	leave  
  10134a:	c3                   	ret    

0010134b <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  10134b:	55                   	push   %ebp
  10134c:	89 e5                	mov    %esp,%ebp
  10134e:	83 ec 10             	sub    $0x10,%esp
  101351:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101357:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10135b:	89 c2                	mov    %eax,%edx
  10135d:	ec                   	in     (%dx),%al
  10135e:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101361:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101365:	0f b6 c0             	movzbl %al,%eax
  101368:	83 e0 01             	and    $0x1,%eax
  10136b:	85 c0                	test   %eax,%eax
  10136d:	75 07                	jne    101376 <serial_proc_data+0x2b>
        return -1;
  10136f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101374:	eb 2a                	jmp    1013a0 <serial_proc_data+0x55>
  101376:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10137c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  101380:	89 c2                	mov    %eax,%edx
  101382:	ec                   	in     (%dx),%al
  101383:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  101386:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  10138a:	0f b6 c0             	movzbl %al,%eax
  10138d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  101390:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101394:	75 07                	jne    10139d <serial_proc_data+0x52>
        c = '\b';
  101396:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10139d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1013a0:	c9                   	leave  
  1013a1:	c3                   	ret    

001013a2 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  1013a2:	55                   	push   %ebp
  1013a3:	89 e5                	mov    %esp,%ebp
  1013a5:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  1013a8:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1013ad:	85 c0                	test   %eax,%eax
  1013af:	74 0c                	je     1013bd <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  1013b1:	c7 04 24 4b 13 10 00 	movl   $0x10134b,(%esp)
  1013b8:	e8 43 ff ff ff       	call   101300 <cons_intr>
    }
}
  1013bd:	c9                   	leave  
  1013be:	c3                   	ret    

001013bf <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  1013bf:	55                   	push   %ebp
  1013c0:	89 e5                	mov    %esp,%ebp
  1013c2:	83 ec 38             	sub    $0x38,%esp
  1013c5:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013cb:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1013cf:	89 c2                	mov    %eax,%edx
  1013d1:	ec                   	in     (%dx),%al
  1013d2:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  1013d5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  1013d9:	0f b6 c0             	movzbl %al,%eax
  1013dc:	83 e0 01             	and    $0x1,%eax
  1013df:	85 c0                	test   %eax,%eax
  1013e1:	75 0a                	jne    1013ed <kbd_proc_data+0x2e>
        return -1;
  1013e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1013e8:	e9 59 01 00 00       	jmp    101546 <kbd_proc_data+0x187>
  1013ed:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013f3:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  1013f7:	89 c2                	mov    %eax,%edx
  1013f9:	ec                   	in     (%dx),%al
  1013fa:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  1013fd:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  101401:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101404:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  101408:	75 17                	jne    101421 <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  10140a:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10140f:	83 c8 40             	or     $0x40,%eax
  101412:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101417:	b8 00 00 00 00       	mov    $0x0,%eax
  10141c:	e9 25 01 00 00       	jmp    101546 <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  101421:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101425:	84 c0                	test   %al,%al
  101427:	79 47                	jns    101470 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  101429:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10142e:	83 e0 40             	and    $0x40,%eax
  101431:	85 c0                	test   %eax,%eax
  101433:	75 09                	jne    10143e <kbd_proc_data+0x7f>
  101435:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101439:	83 e0 7f             	and    $0x7f,%eax
  10143c:	eb 04                	jmp    101442 <kbd_proc_data+0x83>
  10143e:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101442:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101445:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101449:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  101450:	83 c8 40             	or     $0x40,%eax
  101453:	0f b6 c0             	movzbl %al,%eax
  101456:	f7 d0                	not    %eax
  101458:	89 c2                	mov    %eax,%edx
  10145a:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10145f:	21 d0                	and    %edx,%eax
  101461:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101466:	b8 00 00 00 00       	mov    $0x0,%eax
  10146b:	e9 d6 00 00 00       	jmp    101546 <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  101470:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101475:	83 e0 40             	and    $0x40,%eax
  101478:	85 c0                	test   %eax,%eax
  10147a:	74 11                	je     10148d <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  10147c:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101480:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101485:	83 e0 bf             	and    $0xffffffbf,%eax
  101488:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  10148d:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101491:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  101498:	0f b6 d0             	movzbl %al,%edx
  10149b:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014a0:	09 d0                	or     %edx,%eax
  1014a2:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  1014a7:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014ab:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  1014b2:	0f b6 d0             	movzbl %al,%edx
  1014b5:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014ba:	31 d0                	xor    %edx,%eax
  1014bc:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  1014c1:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014c6:	83 e0 03             	and    $0x3,%eax
  1014c9:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  1014d0:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014d4:	01 d0                	add    %edx,%eax
  1014d6:	0f b6 00             	movzbl (%eax),%eax
  1014d9:	0f b6 c0             	movzbl %al,%eax
  1014dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1014df:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014e4:	83 e0 08             	and    $0x8,%eax
  1014e7:	85 c0                	test   %eax,%eax
  1014e9:	74 22                	je     10150d <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  1014eb:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1014ef:	7e 0c                	jle    1014fd <kbd_proc_data+0x13e>
  1014f1:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1014f5:	7f 06                	jg     1014fd <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  1014f7:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1014fb:	eb 10                	jmp    10150d <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1014fd:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  101501:	7e 0a                	jle    10150d <kbd_proc_data+0x14e>
  101503:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  101507:	7f 04                	jg     10150d <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  101509:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  10150d:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101512:	f7 d0                	not    %eax
  101514:	83 e0 06             	and    $0x6,%eax
  101517:	85 c0                	test   %eax,%eax
  101519:	75 28                	jne    101543 <kbd_proc_data+0x184>
  10151b:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  101522:	75 1f                	jne    101543 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  101524:	c7 04 24 9d 38 10 00 	movl   $0x10389d,(%esp)
  10152b:	e8 f2 ed ff ff       	call   100322 <cprintf>
  101530:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101536:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10153a:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  10153e:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101542:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101543:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101546:	c9                   	leave  
  101547:	c3                   	ret    

00101548 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101548:	55                   	push   %ebp
  101549:	89 e5                	mov    %esp,%ebp
  10154b:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  10154e:	c7 04 24 bf 13 10 00 	movl   $0x1013bf,(%esp)
  101555:	e8 a6 fd ff ff       	call   101300 <cons_intr>
}
  10155a:	c9                   	leave  
  10155b:	c3                   	ret    

0010155c <kbd_init>:

static void
kbd_init(void) {
  10155c:	55                   	push   %ebp
  10155d:	89 e5                	mov    %esp,%ebp
  10155f:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  101562:	e8 e1 ff ff ff       	call   101548 <kbd_intr>
    pic_enable(IRQ_KBD);
  101567:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10156e:	e8 17 01 00 00       	call   10168a <pic_enable>
}
  101573:	c9                   	leave  
  101574:	c3                   	ret    

00101575 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101575:	55                   	push   %ebp
  101576:	89 e5                	mov    %esp,%ebp
  101578:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  10157b:	e8 93 f8 ff ff       	call   100e13 <cga_init>
    serial_init();
  101580:	e8 74 f9 ff ff       	call   100ef9 <serial_init>
    kbd_init();
  101585:	e8 d2 ff ff ff       	call   10155c <kbd_init>
    if (!serial_exists) {
  10158a:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  10158f:	85 c0                	test   %eax,%eax
  101591:	75 0c                	jne    10159f <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  101593:	c7 04 24 a9 38 10 00 	movl   $0x1038a9,(%esp)
  10159a:	e8 83 ed ff ff       	call   100322 <cprintf>
    }
}
  10159f:	c9                   	leave  
  1015a0:	c3                   	ret    

001015a1 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  1015a1:	55                   	push   %ebp
  1015a2:	89 e5                	mov    %esp,%ebp
  1015a4:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  1015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  1015aa:	89 04 24             	mov    %eax,(%esp)
  1015ad:	e8 a3 fa ff ff       	call   101055 <lpt_putc>
    cga_putc(c);
  1015b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1015b5:	89 04 24             	mov    %eax,(%esp)
  1015b8:	e8 d7 fa ff ff       	call   101094 <cga_putc>
    serial_putc(c);
  1015bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1015c0:	89 04 24             	mov    %eax,(%esp)
  1015c3:	e8 f9 fc ff ff       	call   1012c1 <serial_putc>
}
  1015c8:	c9                   	leave  
  1015c9:	c3                   	ret    

001015ca <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1015ca:	55                   	push   %ebp
  1015cb:	89 e5                	mov    %esp,%ebp
  1015cd:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1015d0:	e8 cd fd ff ff       	call   1013a2 <serial_intr>
    kbd_intr();
  1015d5:	e8 6e ff ff ff       	call   101548 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1015da:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  1015e0:	a1 84 f0 10 00       	mov    0x10f084,%eax
  1015e5:	39 c2                	cmp    %eax,%edx
  1015e7:	74 36                	je     10161f <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  1015e9:	a1 80 f0 10 00       	mov    0x10f080,%eax
  1015ee:	8d 50 01             	lea    0x1(%eax),%edx
  1015f1:	89 15 80 f0 10 00    	mov    %edx,0x10f080
  1015f7:	0f b6 80 80 ee 10 00 	movzbl 0x10ee80(%eax),%eax
  1015fe:	0f b6 c0             	movzbl %al,%eax
  101601:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101604:	a1 80 f0 10 00       	mov    0x10f080,%eax
  101609:	3d 00 02 00 00       	cmp    $0x200,%eax
  10160e:	75 0a                	jne    10161a <cons_getc+0x50>
            cons.rpos = 0;
  101610:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  101617:	00 00 00 
        }
        return c;
  10161a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10161d:	eb 05                	jmp    101624 <cons_getc+0x5a>
    }
    return 0;
  10161f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101624:	c9                   	leave  
  101625:	c3                   	ret    

00101626 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  101626:	55                   	push   %ebp
  101627:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  101629:	fb                   	sti    
    sti();
}
  10162a:	5d                   	pop    %ebp
  10162b:	c3                   	ret    

0010162c <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  10162c:	55                   	push   %ebp
  10162d:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  10162f:	fa                   	cli    
    cli();
}
  101630:	5d                   	pop    %ebp
  101631:	c3                   	ret    

00101632 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101632:	55                   	push   %ebp
  101633:	89 e5                	mov    %esp,%ebp
  101635:	83 ec 14             	sub    $0x14,%esp
  101638:	8b 45 08             	mov    0x8(%ebp),%eax
  10163b:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  10163f:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101643:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  101649:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  10164e:	85 c0                	test   %eax,%eax
  101650:	74 36                	je     101688 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  101652:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101656:	0f b6 c0             	movzbl %al,%eax
  101659:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  10165f:	88 45 fd             	mov    %al,-0x3(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101662:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101666:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  10166a:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  10166b:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10166f:	66 c1 e8 08          	shr    $0x8,%ax
  101673:	0f b6 c0             	movzbl %al,%eax
  101676:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  10167c:	88 45 f9             	mov    %al,-0x7(%ebp)
  10167f:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101683:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101687:	ee                   	out    %al,(%dx)
    }
}
  101688:	c9                   	leave  
  101689:	c3                   	ret    

0010168a <pic_enable>:

void
pic_enable(unsigned int irq) {
  10168a:	55                   	push   %ebp
  10168b:	89 e5                	mov    %esp,%ebp
  10168d:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  101690:	8b 45 08             	mov    0x8(%ebp),%eax
  101693:	ba 01 00 00 00       	mov    $0x1,%edx
  101698:	89 c1                	mov    %eax,%ecx
  10169a:	d3 e2                	shl    %cl,%edx
  10169c:	89 d0                	mov    %edx,%eax
  10169e:	f7 d0                	not    %eax
  1016a0:	89 c2                	mov    %eax,%edx
  1016a2:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1016a9:	21 d0                	and    %edx,%eax
  1016ab:	0f b7 c0             	movzwl %ax,%eax
  1016ae:	89 04 24             	mov    %eax,(%esp)
  1016b1:	e8 7c ff ff ff       	call   101632 <pic_setmask>
}
  1016b6:	c9                   	leave  
  1016b7:	c3                   	ret    

001016b8 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1016b8:	55                   	push   %ebp
  1016b9:	89 e5                	mov    %esp,%ebp
  1016bb:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  1016be:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  1016c5:	00 00 00 
  1016c8:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  1016ce:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
  1016d2:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  1016d6:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1016da:	ee                   	out    %al,(%dx)
  1016db:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  1016e1:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
  1016e5:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1016e9:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1016ed:	ee                   	out    %al,(%dx)
  1016ee:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  1016f4:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
  1016f8:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1016fc:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  101700:	ee                   	out    %al,(%dx)
  101701:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
  101707:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
  10170b:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10170f:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101713:	ee                   	out    %al,(%dx)
  101714:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
  10171a:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
  10171e:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101722:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101726:	ee                   	out    %al,(%dx)
  101727:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
  10172d:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
  101731:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101735:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101739:	ee                   	out    %al,(%dx)
  10173a:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  101740:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
  101744:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101748:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10174c:	ee                   	out    %al,(%dx)
  10174d:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
  101753:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
  101757:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  10175b:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10175f:	ee                   	out    %al,(%dx)
  101760:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
  101766:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
  10176a:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10176e:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  101772:	ee                   	out    %al,(%dx)
  101773:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
  101779:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
  10177d:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  101781:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  101785:	ee                   	out    %al,(%dx)
  101786:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
  10178c:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
  101790:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  101794:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  101798:	ee                   	out    %al,(%dx)
  101799:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  10179f:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
  1017a3:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017a7:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017ab:	ee                   	out    %al,(%dx)
  1017ac:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
  1017b2:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
  1017b6:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017ba:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017be:	ee                   	out    %al,(%dx)
  1017bf:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
  1017c5:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
  1017c9:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017cd:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017d1:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1017d2:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1017d9:	66 83 f8 ff          	cmp    $0xffff,%ax
  1017dd:	74 12                	je     1017f1 <pic_init+0x139>
        pic_setmask(irq_mask);
  1017df:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1017e6:	0f b7 c0             	movzwl %ax,%eax
  1017e9:	89 04 24             	mov    %eax,(%esp)
  1017ec:	e8 41 fe ff ff       	call   101632 <pic_setmask>
    }
}
  1017f1:	c9                   	leave  
  1017f2:	c3                   	ret    

001017f3 <print_ticks>:
#include <console.h>
#include <kdebug.h>
#include <string.h>
#define TICK_NUM 100

static void print_ticks() {
  1017f3:	55                   	push   %ebp
  1017f4:	89 e5                	mov    %esp,%ebp
  1017f6:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1017f9:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  101800:	00 
  101801:	c7 04 24 e0 38 10 00 	movl   $0x1038e0,(%esp)
  101808:	e8 15 eb ff ff       	call   100322 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  10180d:	c9                   	leave  
  10180e:	c3                   	ret    

0010180f <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  10180f:	55                   	push   %ebp
  101810:	89 e5                	mov    %esp,%ebp
  101812:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101815:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10181c:	e9 c3 00 00 00       	jmp    1018e4 <idt_init+0xd5>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101821:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101824:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  10182b:	89 c2                	mov    %eax,%edx
  10182d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101830:	66 89 14 c5 a0 f0 10 	mov    %dx,0x10f0a0(,%eax,8)
  101837:	00 
  101838:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10183b:	66 c7 04 c5 a2 f0 10 	movw   $0x8,0x10f0a2(,%eax,8)
  101842:	00 08 00 
  101845:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101848:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  10184f:	00 
  101850:	83 e2 e0             	and    $0xffffffe0,%edx
  101853:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  10185a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10185d:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  101864:	00 
  101865:	83 e2 1f             	and    $0x1f,%edx
  101868:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  10186f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101872:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101879:	00 
  10187a:	83 e2 f0             	and    $0xfffffff0,%edx
  10187d:	83 ca 0e             	or     $0xe,%edx
  101880:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101887:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10188a:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101891:	00 
  101892:	83 e2 ef             	and    $0xffffffef,%edx
  101895:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  10189c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10189f:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018a6:	00 
  1018a7:	83 e2 9f             	and    $0xffffff9f,%edx
  1018aa:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018b4:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018bb:	00 
  1018bc:	83 ca 80             	or     $0xffffff80,%edx
  1018bf:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018c9:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  1018d0:	c1 e8 10             	shr    $0x10,%eax
  1018d3:	89 c2                	mov    %eax,%edx
  1018d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018d8:	66 89 14 c5 a6 f0 10 	mov    %dx,0x10f0a6(,%eax,8)
  1018df:	00 
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  1018e0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1018e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018e7:	3d ff 00 00 00       	cmp    $0xff,%eax
  1018ec:	0f 86 2f ff ff ff    	jbe    101821 <idt_init+0x12>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
    }
	// set for switch from user to kernel
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  1018f2:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  1018f7:	66 a3 68 f4 10 00    	mov    %ax,0x10f468
  1018fd:	66 c7 05 6a f4 10 00 	movw   $0x8,0x10f46a
  101904:	08 00 
  101906:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  10190d:	83 e0 e0             	and    $0xffffffe0,%eax
  101910:	a2 6c f4 10 00       	mov    %al,0x10f46c
  101915:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  10191c:	83 e0 1f             	and    $0x1f,%eax
  10191f:	a2 6c f4 10 00       	mov    %al,0x10f46c
  101924:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  10192b:	83 e0 f0             	and    $0xfffffff0,%eax
  10192e:	83 c8 0e             	or     $0xe,%eax
  101931:	a2 6d f4 10 00       	mov    %al,0x10f46d
  101936:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  10193d:	83 e0 ef             	and    $0xffffffef,%eax
  101940:	a2 6d f4 10 00       	mov    %al,0x10f46d
  101945:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  10194c:	83 c8 60             	or     $0x60,%eax
  10194f:	a2 6d f4 10 00       	mov    %al,0x10f46d
  101954:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  10195b:	83 c8 80             	or     $0xffffff80,%eax
  10195e:	a2 6d f4 10 00       	mov    %al,0x10f46d
  101963:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  101968:	c1 e8 10             	shr    $0x10,%eax
  10196b:	66 a3 6e f4 10 00    	mov    %ax,0x10f46e
  101971:	c7 45 f8 60 e5 10 00 	movl   $0x10e560,-0x8(%ebp)
    return ebp;
}

static inline void
lidt(struct pseudodesc *pd) {
    asm volatile ("lidt (%0)" :: "r" (pd));
  101978:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10197b:	0f 01 18             	lidtl  (%eax)
	// load the IDT
    lidt(&idt_pd);
}
  10197e:	c9                   	leave  
  10197f:	c3                   	ret    

00101980 <trapname>:

static const char *
trapname(int trapno) {
  101980:	55                   	push   %ebp
  101981:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  101983:	8b 45 08             	mov    0x8(%ebp),%eax
  101986:	83 f8 13             	cmp    $0x13,%eax
  101989:	77 0c                	ja     101997 <trapname+0x17>
        return excnames[trapno];
  10198b:	8b 45 08             	mov    0x8(%ebp),%eax
  10198e:	8b 04 85 40 3c 10 00 	mov    0x103c40(,%eax,4),%eax
  101995:	eb 18                	jmp    1019af <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101997:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  10199b:	7e 0d                	jle    1019aa <trapname+0x2a>
  10199d:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  1019a1:	7f 07                	jg     1019aa <trapname+0x2a>
        return "Hardware Interrupt";
  1019a3:	b8 ea 38 10 00       	mov    $0x1038ea,%eax
  1019a8:	eb 05                	jmp    1019af <trapname+0x2f>
    }
    return "(unknown trap)";
  1019aa:	b8 fd 38 10 00       	mov    $0x1038fd,%eax
}
  1019af:	5d                   	pop    %ebp
  1019b0:	c3                   	ret    

001019b1 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  1019b1:	55                   	push   %ebp
  1019b2:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  1019b4:	8b 45 08             	mov    0x8(%ebp),%eax
  1019b7:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  1019bb:	66 83 f8 08          	cmp    $0x8,%ax
  1019bf:	0f 94 c0             	sete   %al
  1019c2:	0f b6 c0             	movzbl %al,%eax
}
  1019c5:	5d                   	pop    %ebp
  1019c6:	c3                   	ret    

001019c7 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  1019c7:	55                   	push   %ebp
  1019c8:	89 e5                	mov    %esp,%ebp
  1019ca:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  1019cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1019d0:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019d4:	c7 04 24 3e 39 10 00 	movl   $0x10393e,(%esp)
  1019db:	e8 42 e9 ff ff       	call   100322 <cprintf>
    print_regs(&tf->tf_regs);
  1019e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1019e3:	89 04 24             	mov    %eax,(%esp)
  1019e6:	e8 a1 01 00 00       	call   101b8c <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  1019eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ee:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  1019f2:	0f b7 c0             	movzwl %ax,%eax
  1019f5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019f9:	c7 04 24 4f 39 10 00 	movl   $0x10394f,(%esp)
  101a00:	e8 1d e9 ff ff       	call   100322 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101a05:	8b 45 08             	mov    0x8(%ebp),%eax
  101a08:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101a0c:	0f b7 c0             	movzwl %ax,%eax
  101a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a13:	c7 04 24 62 39 10 00 	movl   $0x103962,(%esp)
  101a1a:	e8 03 e9 ff ff       	call   100322 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  101a22:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101a26:	0f b7 c0             	movzwl %ax,%eax
  101a29:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a2d:	c7 04 24 75 39 10 00 	movl   $0x103975,(%esp)
  101a34:	e8 e9 e8 ff ff       	call   100322 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101a39:	8b 45 08             	mov    0x8(%ebp),%eax
  101a3c:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101a40:	0f b7 c0             	movzwl %ax,%eax
  101a43:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a47:	c7 04 24 88 39 10 00 	movl   $0x103988,(%esp)
  101a4e:	e8 cf e8 ff ff       	call   100322 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101a53:	8b 45 08             	mov    0x8(%ebp),%eax
  101a56:	8b 40 30             	mov    0x30(%eax),%eax
  101a59:	89 04 24             	mov    %eax,(%esp)
  101a5c:	e8 1f ff ff ff       	call   101980 <trapname>
  101a61:	8b 55 08             	mov    0x8(%ebp),%edx
  101a64:	8b 52 30             	mov    0x30(%edx),%edx
  101a67:	89 44 24 08          	mov    %eax,0x8(%esp)
  101a6b:	89 54 24 04          	mov    %edx,0x4(%esp)
  101a6f:	c7 04 24 9b 39 10 00 	movl   $0x10399b,(%esp)
  101a76:	e8 a7 e8 ff ff       	call   100322 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101a7b:	8b 45 08             	mov    0x8(%ebp),%eax
  101a7e:	8b 40 34             	mov    0x34(%eax),%eax
  101a81:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a85:	c7 04 24 ad 39 10 00 	movl   $0x1039ad,(%esp)
  101a8c:	e8 91 e8 ff ff       	call   100322 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101a91:	8b 45 08             	mov    0x8(%ebp),%eax
  101a94:	8b 40 38             	mov    0x38(%eax),%eax
  101a97:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a9b:	c7 04 24 bc 39 10 00 	movl   $0x1039bc,(%esp)
  101aa2:	e8 7b e8 ff ff       	call   100322 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101aa7:	8b 45 08             	mov    0x8(%ebp),%eax
  101aaa:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101aae:	0f b7 c0             	movzwl %ax,%eax
  101ab1:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ab5:	c7 04 24 cb 39 10 00 	movl   $0x1039cb,(%esp)
  101abc:	e8 61 e8 ff ff       	call   100322 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  101ac4:	8b 40 40             	mov    0x40(%eax),%eax
  101ac7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101acb:	c7 04 24 de 39 10 00 	movl   $0x1039de,(%esp)
  101ad2:	e8 4b e8 ff ff       	call   100322 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101ad7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101ade:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101ae5:	eb 3e                	jmp    101b25 <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  101aea:	8b 50 40             	mov    0x40(%eax),%edx
  101aed:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101af0:	21 d0                	and    %edx,%eax
  101af2:	85 c0                	test   %eax,%eax
  101af4:	74 28                	je     101b1e <print_trapframe+0x157>
  101af6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101af9:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b00:	85 c0                	test   %eax,%eax
  101b02:	74 1a                	je     101b1e <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
  101b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b07:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b0e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b12:	c7 04 24 ed 39 10 00 	movl   $0x1039ed,(%esp)
  101b19:	e8 04 e8 ff ff       	call   100322 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b1e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101b22:	d1 65 f0             	shll   -0x10(%ebp)
  101b25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b28:	83 f8 17             	cmp    $0x17,%eax
  101b2b:	76 ba                	jbe    101ae7 <print_trapframe+0x120>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  101b30:	8b 40 40             	mov    0x40(%eax),%eax
  101b33:	25 00 30 00 00       	and    $0x3000,%eax
  101b38:	c1 e8 0c             	shr    $0xc,%eax
  101b3b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b3f:	c7 04 24 f1 39 10 00 	movl   $0x1039f1,(%esp)
  101b46:	e8 d7 e7 ff ff       	call   100322 <cprintf>

    if (!trap_in_kernel(tf)) {
  101b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b4e:	89 04 24             	mov    %eax,(%esp)
  101b51:	e8 5b fe ff ff       	call   1019b1 <trap_in_kernel>
  101b56:	85 c0                	test   %eax,%eax
  101b58:	75 30                	jne    101b8a <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101b5a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b5d:	8b 40 44             	mov    0x44(%eax),%eax
  101b60:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b64:	c7 04 24 fa 39 10 00 	movl   $0x1039fa,(%esp)
  101b6b:	e8 b2 e7 ff ff       	call   100322 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101b70:	8b 45 08             	mov    0x8(%ebp),%eax
  101b73:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101b77:	0f b7 c0             	movzwl %ax,%eax
  101b7a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b7e:	c7 04 24 09 3a 10 00 	movl   $0x103a09,(%esp)
  101b85:	e8 98 e7 ff ff       	call   100322 <cprintf>
    }
}
  101b8a:	c9                   	leave  
  101b8b:	c3                   	ret    

00101b8c <print_regs>:

void
print_regs(struct pushregs *regs) {
  101b8c:	55                   	push   %ebp
  101b8d:	89 e5                	mov    %esp,%ebp
  101b8f:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101b92:	8b 45 08             	mov    0x8(%ebp),%eax
  101b95:	8b 00                	mov    (%eax),%eax
  101b97:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b9b:	c7 04 24 1c 3a 10 00 	movl   $0x103a1c,(%esp)
  101ba2:	e8 7b e7 ff ff       	call   100322 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101ba7:	8b 45 08             	mov    0x8(%ebp),%eax
  101baa:	8b 40 04             	mov    0x4(%eax),%eax
  101bad:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bb1:	c7 04 24 2b 3a 10 00 	movl   $0x103a2b,(%esp)
  101bb8:	e8 65 e7 ff ff       	call   100322 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  101bc0:	8b 40 08             	mov    0x8(%eax),%eax
  101bc3:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bc7:	c7 04 24 3a 3a 10 00 	movl   $0x103a3a,(%esp)
  101bce:	e8 4f e7 ff ff       	call   100322 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd6:	8b 40 0c             	mov    0xc(%eax),%eax
  101bd9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bdd:	c7 04 24 49 3a 10 00 	movl   $0x103a49,(%esp)
  101be4:	e8 39 e7 ff ff       	call   100322 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101be9:	8b 45 08             	mov    0x8(%ebp),%eax
  101bec:	8b 40 10             	mov    0x10(%eax),%eax
  101bef:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bf3:	c7 04 24 58 3a 10 00 	movl   $0x103a58,(%esp)
  101bfa:	e8 23 e7 ff ff       	call   100322 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101bff:	8b 45 08             	mov    0x8(%ebp),%eax
  101c02:	8b 40 14             	mov    0x14(%eax),%eax
  101c05:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c09:	c7 04 24 67 3a 10 00 	movl   $0x103a67,(%esp)
  101c10:	e8 0d e7 ff ff       	call   100322 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101c15:	8b 45 08             	mov    0x8(%ebp),%eax
  101c18:	8b 40 18             	mov    0x18(%eax),%eax
  101c1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c1f:	c7 04 24 76 3a 10 00 	movl   $0x103a76,(%esp)
  101c26:	e8 f7 e6 ff ff       	call   100322 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  101c2e:	8b 40 1c             	mov    0x1c(%eax),%eax
  101c31:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c35:	c7 04 24 85 3a 10 00 	movl   $0x103a85,(%esp)
  101c3c:	e8 e1 e6 ff ff       	call   100322 <cprintf>
}
  101c41:	c9                   	leave  
  101c42:	c3                   	ret    

00101c43 <trap_dispatch>:
/* temporary trapframe or pointer to trapframe */
struct trapframe switchk2u, *switchu2k;

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101c43:	55                   	push   %ebp
  101c44:	89 e5                	mov    %esp,%ebp
  101c46:	57                   	push   %edi
  101c47:	56                   	push   %esi
  101c48:	53                   	push   %ebx
  101c49:	83 ec 2c             	sub    $0x2c,%esp
    char c;

    switch (tf->tf_trapno) {
  101c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  101c4f:	8b 40 30             	mov    0x30(%eax),%eax
  101c52:	83 f8 2f             	cmp    $0x2f,%eax
  101c55:	77 21                	ja     101c78 <trap_dispatch+0x35>
  101c57:	83 f8 2e             	cmp    $0x2e,%eax
  101c5a:	0f 83 ec 01 00 00    	jae    101e4c <trap_dispatch+0x209>
  101c60:	83 f8 21             	cmp    $0x21,%eax
  101c63:	0f 84 8a 00 00 00    	je     101cf3 <trap_dispatch+0xb0>
  101c69:	83 f8 24             	cmp    $0x24,%eax
  101c6c:	74 5c                	je     101cca <trap_dispatch+0x87>
  101c6e:	83 f8 20             	cmp    $0x20,%eax
  101c71:	74 1c                	je     101c8f <trap_dispatch+0x4c>
  101c73:	e9 9c 01 00 00       	jmp    101e14 <trap_dispatch+0x1d1>
  101c78:	83 f8 78             	cmp    $0x78,%eax
  101c7b:	0f 84 9b 00 00 00    	je     101d1c <trap_dispatch+0xd9>
  101c81:	83 f8 79             	cmp    $0x79,%eax
  101c84:	0f 84 11 01 00 00    	je     101d9b <trap_dispatch+0x158>
  101c8a:	e9 85 01 00 00       	jmp    101e14 <trap_dispatch+0x1d1>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks ++;
  101c8f:	a1 08 f9 10 00       	mov    0x10f908,%eax
  101c94:	83 c0 01             	add    $0x1,%eax
  101c97:	a3 08 f9 10 00       	mov    %eax,0x10f908
        if (ticks % TICK_NUM == 0) {
  101c9c:	8b 0d 08 f9 10 00    	mov    0x10f908,%ecx
  101ca2:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101ca7:	89 c8                	mov    %ecx,%eax
  101ca9:	f7 e2                	mul    %edx
  101cab:	89 d0                	mov    %edx,%eax
  101cad:	c1 e8 05             	shr    $0x5,%eax
  101cb0:	6b c0 64             	imul   $0x64,%eax,%eax
  101cb3:	29 c1                	sub    %eax,%ecx
  101cb5:	89 c8                	mov    %ecx,%eax
  101cb7:	85 c0                	test   %eax,%eax
  101cb9:	75 0a                	jne    101cc5 <trap_dispatch+0x82>
            print_ticks();
  101cbb:	e8 33 fb ff ff       	call   1017f3 <print_ticks>
        }
        break;
  101cc0:	e9 88 01 00 00       	jmp    101e4d <trap_dispatch+0x20a>
  101cc5:	e9 83 01 00 00       	jmp    101e4d <trap_dispatch+0x20a>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101cca:	e8 fb f8 ff ff       	call   1015ca <cons_getc>
  101ccf:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101cd2:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101cd6:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101cda:	89 54 24 08          	mov    %edx,0x8(%esp)
  101cde:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ce2:	c7 04 24 94 3a 10 00 	movl   $0x103a94,(%esp)
  101ce9:	e8 34 e6 ff ff       	call   100322 <cprintf>
        break;
  101cee:	e9 5a 01 00 00       	jmp    101e4d <trap_dispatch+0x20a>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101cf3:	e8 d2 f8 ff ff       	call   1015ca <cons_getc>
  101cf8:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101cfb:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101cff:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101d03:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d07:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d0b:	c7 04 24 a6 3a 10 00 	movl   $0x103aa6,(%esp)
  101d12:	e8 0b e6 ff ff       	call   100322 <cprintf>
        break;
  101d17:	e9 31 01 00 00       	jmp    101e4d <trap_dispatch+0x20a>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) {
  101d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  101d1f:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101d23:	66 83 f8 1b          	cmp    $0x1b,%ax
  101d27:	74 6d                	je     101d96 <trap_dispatch+0x153>
            switchk2u = *tf;
  101d29:	8b 45 08             	mov    0x8(%ebp),%eax
  101d2c:	ba 20 f9 10 00       	mov    $0x10f920,%edx
  101d31:	89 c3                	mov    %eax,%ebx
  101d33:	b8 13 00 00 00       	mov    $0x13,%eax
  101d38:	89 d7                	mov    %edx,%edi
  101d3a:	89 de                	mov    %ebx,%esi
  101d3c:	89 c1                	mov    %eax,%ecx
  101d3e:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            switchk2u.tf_cs = USER_CS;
  101d40:	66 c7 05 5c f9 10 00 	movw   $0x1b,0x10f95c
  101d47:	1b 00 
            switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
  101d49:	66 c7 05 68 f9 10 00 	movw   $0x23,0x10f968
  101d50:	23 00 
  101d52:	0f b7 05 68 f9 10 00 	movzwl 0x10f968,%eax
  101d59:	66 a3 48 f9 10 00    	mov    %ax,0x10f948
  101d5f:	0f b7 05 48 f9 10 00 	movzwl 0x10f948,%eax
  101d66:	66 a3 4c f9 10 00    	mov    %ax,0x10f94c
            switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  101d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  101d6f:	83 c0 44             	add    $0x44,%eax
  101d72:	a3 64 f9 10 00       	mov    %eax,0x10f964
		
            // set eflags, make sure ucore can use io under user mode.
            // if CPL > IOPL, then cpu will generate a general protection.
            switchk2u.tf_eflags |= FL_IOPL_MASK;
  101d77:	a1 60 f9 10 00       	mov    0x10f960,%eax
  101d7c:	80 cc 30             	or     $0x30,%ah
  101d7f:	a3 60 f9 10 00       	mov    %eax,0x10f960
		
            // set temporary stack
            // then iret will jump to the right stack
            *((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  101d84:	8b 45 08             	mov    0x8(%ebp),%eax
  101d87:	8d 50 fc             	lea    -0x4(%eax),%edx
  101d8a:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  101d8f:	89 02                	mov    %eax,(%edx)
        }
        break;
  101d91:	e9 b7 00 00 00       	jmp    101e4d <trap_dispatch+0x20a>
  101d96:	e9 b2 00 00 00       	jmp    101e4d <trap_dispatch+0x20a>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  101d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  101d9e:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101da2:	66 83 f8 08          	cmp    $0x8,%ax
  101da6:	74 6a                	je     101e12 <trap_dispatch+0x1cf>
            tf->tf_cs = KERNEL_CS;
  101da8:	8b 45 08             	mov    0x8(%ebp),%eax
  101dab:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101db1:	8b 45 08             	mov    0x8(%ebp),%eax
  101db4:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101dba:	8b 45 08             	mov    0x8(%ebp),%eax
  101dbd:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  101dc4:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  101dcb:	8b 40 40             	mov    0x40(%eax),%eax
  101dce:	80 e4 cf             	and    $0xcf,%ah
  101dd1:	89 c2                	mov    %eax,%edx
  101dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  101dd6:	89 50 40             	mov    %edx,0x40(%eax)
            switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  101dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  101ddc:	8b 40 44             	mov    0x44(%eax),%eax
  101ddf:	83 e8 44             	sub    $0x44,%eax
  101de2:	a3 6c f9 10 00       	mov    %eax,0x10f96c
            memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  101de7:	a1 6c f9 10 00       	mov    0x10f96c,%eax
  101dec:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  101df3:	00 
  101df4:	8b 55 08             	mov    0x8(%ebp),%edx
  101df7:	89 54 24 04          	mov    %edx,0x4(%esp)
  101dfb:	89 04 24             	mov    %eax,(%esp)
  101dfe:	e8 25 16 00 00       	call   103428 <memmove>
            *((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  101e03:	8b 45 08             	mov    0x8(%ebp),%eax
  101e06:	8d 50 fc             	lea    -0x4(%eax),%edx
  101e09:	a1 6c f9 10 00       	mov    0x10f96c,%eax
  101e0e:	89 02                	mov    %eax,(%edx)
        }
        break;
  101e10:	eb 3b                	jmp    101e4d <trap_dispatch+0x20a>
  101e12:	eb 39                	jmp    101e4d <trap_dispatch+0x20a>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101e14:	8b 45 08             	mov    0x8(%ebp),%eax
  101e17:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e1b:	0f b7 c0             	movzwl %ax,%eax
  101e1e:	83 e0 03             	and    $0x3,%eax
  101e21:	85 c0                	test   %eax,%eax
  101e23:	75 28                	jne    101e4d <trap_dispatch+0x20a>
            print_trapframe(tf);
  101e25:	8b 45 08             	mov    0x8(%ebp),%eax
  101e28:	89 04 24             	mov    %eax,(%esp)
  101e2b:	e8 97 fb ff ff       	call   1019c7 <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101e30:	c7 44 24 08 b5 3a 10 	movl   $0x103ab5,0x8(%esp)
  101e37:	00 
  101e38:	c7 44 24 04 d2 00 00 	movl   $0xd2,0x4(%esp)
  101e3f:	00 
  101e40:	c7 04 24 d1 3a 10 00 	movl   $0x103ad1,(%esp)
  101e47:	e8 60 ee ff ff       	call   100cac <__panic>
        }
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
  101e4c:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
  101e4d:	83 c4 2c             	add    $0x2c,%esp
  101e50:	5b                   	pop    %ebx
  101e51:	5e                   	pop    %esi
  101e52:	5f                   	pop    %edi
  101e53:	5d                   	pop    %ebp
  101e54:	c3                   	ret    

00101e55 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101e55:	55                   	push   %ebp
  101e56:	89 e5                	mov    %esp,%ebp
  101e58:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  101e5e:	89 04 24             	mov    %eax,(%esp)
  101e61:	e8 dd fd ff ff       	call   101c43 <trap_dispatch>
}
  101e66:	c9                   	leave  
  101e67:	c3                   	ret    

00101e68 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  101e68:	1e                   	push   %ds
    pushl %es
  101e69:	06                   	push   %es
    pushl %fs
  101e6a:	0f a0                	push   %fs
    pushl %gs
  101e6c:	0f a8                	push   %gs
    pushal
  101e6e:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  101e6f:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  101e74:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  101e76:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  101e78:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  101e79:	e8 d7 ff ff ff       	call   101e55 <trap>

    # pop the pushed stack pointer
    popl %esp
  101e7e:	5c                   	pop    %esp

00101e7f <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  101e7f:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  101e80:	0f a9                	pop    %gs
    popl %fs
  101e82:	0f a1                	pop    %fs
    popl %es
  101e84:	07                   	pop    %es
    popl %ds
  101e85:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  101e86:	83 c4 08             	add    $0x8,%esp
    iret
  101e89:	cf                   	iret   

00101e8a <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101e8a:	6a 00                	push   $0x0
  pushl $0
  101e8c:	6a 00                	push   $0x0
  jmp __alltraps
  101e8e:	e9 d5 ff ff ff       	jmp    101e68 <__alltraps>

00101e93 <vector1>:
.globl vector1
vector1:
  pushl $0
  101e93:	6a 00                	push   $0x0
  pushl $1
  101e95:	6a 01                	push   $0x1
  jmp __alltraps
  101e97:	e9 cc ff ff ff       	jmp    101e68 <__alltraps>

00101e9c <vector2>:
.globl vector2
vector2:
  pushl $0
  101e9c:	6a 00                	push   $0x0
  pushl $2
  101e9e:	6a 02                	push   $0x2
  jmp __alltraps
  101ea0:	e9 c3 ff ff ff       	jmp    101e68 <__alltraps>

00101ea5 <vector3>:
.globl vector3
vector3:
  pushl $0
  101ea5:	6a 00                	push   $0x0
  pushl $3
  101ea7:	6a 03                	push   $0x3
  jmp __alltraps
  101ea9:	e9 ba ff ff ff       	jmp    101e68 <__alltraps>

00101eae <vector4>:
.globl vector4
vector4:
  pushl $0
  101eae:	6a 00                	push   $0x0
  pushl $4
  101eb0:	6a 04                	push   $0x4
  jmp __alltraps
  101eb2:	e9 b1 ff ff ff       	jmp    101e68 <__alltraps>

00101eb7 <vector5>:
.globl vector5
vector5:
  pushl $0
  101eb7:	6a 00                	push   $0x0
  pushl $5
  101eb9:	6a 05                	push   $0x5
  jmp __alltraps
  101ebb:	e9 a8 ff ff ff       	jmp    101e68 <__alltraps>

00101ec0 <vector6>:
.globl vector6
vector6:
  pushl $0
  101ec0:	6a 00                	push   $0x0
  pushl $6
  101ec2:	6a 06                	push   $0x6
  jmp __alltraps
  101ec4:	e9 9f ff ff ff       	jmp    101e68 <__alltraps>

00101ec9 <vector7>:
.globl vector7
vector7:
  pushl $0
  101ec9:	6a 00                	push   $0x0
  pushl $7
  101ecb:	6a 07                	push   $0x7
  jmp __alltraps
  101ecd:	e9 96 ff ff ff       	jmp    101e68 <__alltraps>

00101ed2 <vector8>:
.globl vector8
vector8:
  pushl $8
  101ed2:	6a 08                	push   $0x8
  jmp __alltraps
  101ed4:	e9 8f ff ff ff       	jmp    101e68 <__alltraps>

00101ed9 <vector9>:
.globl vector9
vector9:
  pushl $9
  101ed9:	6a 09                	push   $0x9
  jmp __alltraps
  101edb:	e9 88 ff ff ff       	jmp    101e68 <__alltraps>

00101ee0 <vector10>:
.globl vector10
vector10:
  pushl $10
  101ee0:	6a 0a                	push   $0xa
  jmp __alltraps
  101ee2:	e9 81 ff ff ff       	jmp    101e68 <__alltraps>

00101ee7 <vector11>:
.globl vector11
vector11:
  pushl $11
  101ee7:	6a 0b                	push   $0xb
  jmp __alltraps
  101ee9:	e9 7a ff ff ff       	jmp    101e68 <__alltraps>

00101eee <vector12>:
.globl vector12
vector12:
  pushl $12
  101eee:	6a 0c                	push   $0xc
  jmp __alltraps
  101ef0:	e9 73 ff ff ff       	jmp    101e68 <__alltraps>

00101ef5 <vector13>:
.globl vector13
vector13:
  pushl $13
  101ef5:	6a 0d                	push   $0xd
  jmp __alltraps
  101ef7:	e9 6c ff ff ff       	jmp    101e68 <__alltraps>

00101efc <vector14>:
.globl vector14
vector14:
  pushl $14
  101efc:	6a 0e                	push   $0xe
  jmp __alltraps
  101efe:	e9 65 ff ff ff       	jmp    101e68 <__alltraps>

00101f03 <vector15>:
.globl vector15
vector15:
  pushl $0
  101f03:	6a 00                	push   $0x0
  pushl $15
  101f05:	6a 0f                	push   $0xf
  jmp __alltraps
  101f07:	e9 5c ff ff ff       	jmp    101e68 <__alltraps>

00101f0c <vector16>:
.globl vector16
vector16:
  pushl $0
  101f0c:	6a 00                	push   $0x0
  pushl $16
  101f0e:	6a 10                	push   $0x10
  jmp __alltraps
  101f10:	e9 53 ff ff ff       	jmp    101e68 <__alltraps>

00101f15 <vector17>:
.globl vector17
vector17:
  pushl $17
  101f15:	6a 11                	push   $0x11
  jmp __alltraps
  101f17:	e9 4c ff ff ff       	jmp    101e68 <__alltraps>

00101f1c <vector18>:
.globl vector18
vector18:
  pushl $0
  101f1c:	6a 00                	push   $0x0
  pushl $18
  101f1e:	6a 12                	push   $0x12
  jmp __alltraps
  101f20:	e9 43 ff ff ff       	jmp    101e68 <__alltraps>

00101f25 <vector19>:
.globl vector19
vector19:
  pushl $0
  101f25:	6a 00                	push   $0x0
  pushl $19
  101f27:	6a 13                	push   $0x13
  jmp __alltraps
  101f29:	e9 3a ff ff ff       	jmp    101e68 <__alltraps>

00101f2e <vector20>:
.globl vector20
vector20:
  pushl $0
  101f2e:	6a 00                	push   $0x0
  pushl $20
  101f30:	6a 14                	push   $0x14
  jmp __alltraps
  101f32:	e9 31 ff ff ff       	jmp    101e68 <__alltraps>

00101f37 <vector21>:
.globl vector21
vector21:
  pushl $0
  101f37:	6a 00                	push   $0x0
  pushl $21
  101f39:	6a 15                	push   $0x15
  jmp __alltraps
  101f3b:	e9 28 ff ff ff       	jmp    101e68 <__alltraps>

00101f40 <vector22>:
.globl vector22
vector22:
  pushl $0
  101f40:	6a 00                	push   $0x0
  pushl $22
  101f42:	6a 16                	push   $0x16
  jmp __alltraps
  101f44:	e9 1f ff ff ff       	jmp    101e68 <__alltraps>

00101f49 <vector23>:
.globl vector23
vector23:
  pushl $0
  101f49:	6a 00                	push   $0x0
  pushl $23
  101f4b:	6a 17                	push   $0x17
  jmp __alltraps
  101f4d:	e9 16 ff ff ff       	jmp    101e68 <__alltraps>

00101f52 <vector24>:
.globl vector24
vector24:
  pushl $0
  101f52:	6a 00                	push   $0x0
  pushl $24
  101f54:	6a 18                	push   $0x18
  jmp __alltraps
  101f56:	e9 0d ff ff ff       	jmp    101e68 <__alltraps>

00101f5b <vector25>:
.globl vector25
vector25:
  pushl $0
  101f5b:	6a 00                	push   $0x0
  pushl $25
  101f5d:	6a 19                	push   $0x19
  jmp __alltraps
  101f5f:	e9 04 ff ff ff       	jmp    101e68 <__alltraps>

00101f64 <vector26>:
.globl vector26
vector26:
  pushl $0
  101f64:	6a 00                	push   $0x0
  pushl $26
  101f66:	6a 1a                	push   $0x1a
  jmp __alltraps
  101f68:	e9 fb fe ff ff       	jmp    101e68 <__alltraps>

00101f6d <vector27>:
.globl vector27
vector27:
  pushl $0
  101f6d:	6a 00                	push   $0x0
  pushl $27
  101f6f:	6a 1b                	push   $0x1b
  jmp __alltraps
  101f71:	e9 f2 fe ff ff       	jmp    101e68 <__alltraps>

00101f76 <vector28>:
.globl vector28
vector28:
  pushl $0
  101f76:	6a 00                	push   $0x0
  pushl $28
  101f78:	6a 1c                	push   $0x1c
  jmp __alltraps
  101f7a:	e9 e9 fe ff ff       	jmp    101e68 <__alltraps>

00101f7f <vector29>:
.globl vector29
vector29:
  pushl $0
  101f7f:	6a 00                	push   $0x0
  pushl $29
  101f81:	6a 1d                	push   $0x1d
  jmp __alltraps
  101f83:	e9 e0 fe ff ff       	jmp    101e68 <__alltraps>

00101f88 <vector30>:
.globl vector30
vector30:
  pushl $0
  101f88:	6a 00                	push   $0x0
  pushl $30
  101f8a:	6a 1e                	push   $0x1e
  jmp __alltraps
  101f8c:	e9 d7 fe ff ff       	jmp    101e68 <__alltraps>

00101f91 <vector31>:
.globl vector31
vector31:
  pushl $0
  101f91:	6a 00                	push   $0x0
  pushl $31
  101f93:	6a 1f                	push   $0x1f
  jmp __alltraps
  101f95:	e9 ce fe ff ff       	jmp    101e68 <__alltraps>

00101f9a <vector32>:
.globl vector32
vector32:
  pushl $0
  101f9a:	6a 00                	push   $0x0
  pushl $32
  101f9c:	6a 20                	push   $0x20
  jmp __alltraps
  101f9e:	e9 c5 fe ff ff       	jmp    101e68 <__alltraps>

00101fa3 <vector33>:
.globl vector33
vector33:
  pushl $0
  101fa3:	6a 00                	push   $0x0
  pushl $33
  101fa5:	6a 21                	push   $0x21
  jmp __alltraps
  101fa7:	e9 bc fe ff ff       	jmp    101e68 <__alltraps>

00101fac <vector34>:
.globl vector34
vector34:
  pushl $0
  101fac:	6a 00                	push   $0x0
  pushl $34
  101fae:	6a 22                	push   $0x22
  jmp __alltraps
  101fb0:	e9 b3 fe ff ff       	jmp    101e68 <__alltraps>

00101fb5 <vector35>:
.globl vector35
vector35:
  pushl $0
  101fb5:	6a 00                	push   $0x0
  pushl $35
  101fb7:	6a 23                	push   $0x23
  jmp __alltraps
  101fb9:	e9 aa fe ff ff       	jmp    101e68 <__alltraps>

00101fbe <vector36>:
.globl vector36
vector36:
  pushl $0
  101fbe:	6a 00                	push   $0x0
  pushl $36
  101fc0:	6a 24                	push   $0x24
  jmp __alltraps
  101fc2:	e9 a1 fe ff ff       	jmp    101e68 <__alltraps>

00101fc7 <vector37>:
.globl vector37
vector37:
  pushl $0
  101fc7:	6a 00                	push   $0x0
  pushl $37
  101fc9:	6a 25                	push   $0x25
  jmp __alltraps
  101fcb:	e9 98 fe ff ff       	jmp    101e68 <__alltraps>

00101fd0 <vector38>:
.globl vector38
vector38:
  pushl $0
  101fd0:	6a 00                	push   $0x0
  pushl $38
  101fd2:	6a 26                	push   $0x26
  jmp __alltraps
  101fd4:	e9 8f fe ff ff       	jmp    101e68 <__alltraps>

00101fd9 <vector39>:
.globl vector39
vector39:
  pushl $0
  101fd9:	6a 00                	push   $0x0
  pushl $39
  101fdb:	6a 27                	push   $0x27
  jmp __alltraps
  101fdd:	e9 86 fe ff ff       	jmp    101e68 <__alltraps>

00101fe2 <vector40>:
.globl vector40
vector40:
  pushl $0
  101fe2:	6a 00                	push   $0x0
  pushl $40
  101fe4:	6a 28                	push   $0x28
  jmp __alltraps
  101fe6:	e9 7d fe ff ff       	jmp    101e68 <__alltraps>

00101feb <vector41>:
.globl vector41
vector41:
  pushl $0
  101feb:	6a 00                	push   $0x0
  pushl $41
  101fed:	6a 29                	push   $0x29
  jmp __alltraps
  101fef:	e9 74 fe ff ff       	jmp    101e68 <__alltraps>

00101ff4 <vector42>:
.globl vector42
vector42:
  pushl $0
  101ff4:	6a 00                	push   $0x0
  pushl $42
  101ff6:	6a 2a                	push   $0x2a
  jmp __alltraps
  101ff8:	e9 6b fe ff ff       	jmp    101e68 <__alltraps>

00101ffd <vector43>:
.globl vector43
vector43:
  pushl $0
  101ffd:	6a 00                	push   $0x0
  pushl $43
  101fff:	6a 2b                	push   $0x2b
  jmp __alltraps
  102001:	e9 62 fe ff ff       	jmp    101e68 <__alltraps>

00102006 <vector44>:
.globl vector44
vector44:
  pushl $0
  102006:	6a 00                	push   $0x0
  pushl $44
  102008:	6a 2c                	push   $0x2c
  jmp __alltraps
  10200a:	e9 59 fe ff ff       	jmp    101e68 <__alltraps>

0010200f <vector45>:
.globl vector45
vector45:
  pushl $0
  10200f:	6a 00                	push   $0x0
  pushl $45
  102011:	6a 2d                	push   $0x2d
  jmp __alltraps
  102013:	e9 50 fe ff ff       	jmp    101e68 <__alltraps>

00102018 <vector46>:
.globl vector46
vector46:
  pushl $0
  102018:	6a 00                	push   $0x0
  pushl $46
  10201a:	6a 2e                	push   $0x2e
  jmp __alltraps
  10201c:	e9 47 fe ff ff       	jmp    101e68 <__alltraps>

00102021 <vector47>:
.globl vector47
vector47:
  pushl $0
  102021:	6a 00                	push   $0x0
  pushl $47
  102023:	6a 2f                	push   $0x2f
  jmp __alltraps
  102025:	e9 3e fe ff ff       	jmp    101e68 <__alltraps>

0010202a <vector48>:
.globl vector48
vector48:
  pushl $0
  10202a:	6a 00                	push   $0x0
  pushl $48
  10202c:	6a 30                	push   $0x30
  jmp __alltraps
  10202e:	e9 35 fe ff ff       	jmp    101e68 <__alltraps>

00102033 <vector49>:
.globl vector49
vector49:
  pushl $0
  102033:	6a 00                	push   $0x0
  pushl $49
  102035:	6a 31                	push   $0x31
  jmp __alltraps
  102037:	e9 2c fe ff ff       	jmp    101e68 <__alltraps>

0010203c <vector50>:
.globl vector50
vector50:
  pushl $0
  10203c:	6a 00                	push   $0x0
  pushl $50
  10203e:	6a 32                	push   $0x32
  jmp __alltraps
  102040:	e9 23 fe ff ff       	jmp    101e68 <__alltraps>

00102045 <vector51>:
.globl vector51
vector51:
  pushl $0
  102045:	6a 00                	push   $0x0
  pushl $51
  102047:	6a 33                	push   $0x33
  jmp __alltraps
  102049:	e9 1a fe ff ff       	jmp    101e68 <__alltraps>

0010204e <vector52>:
.globl vector52
vector52:
  pushl $0
  10204e:	6a 00                	push   $0x0
  pushl $52
  102050:	6a 34                	push   $0x34
  jmp __alltraps
  102052:	e9 11 fe ff ff       	jmp    101e68 <__alltraps>

00102057 <vector53>:
.globl vector53
vector53:
  pushl $0
  102057:	6a 00                	push   $0x0
  pushl $53
  102059:	6a 35                	push   $0x35
  jmp __alltraps
  10205b:	e9 08 fe ff ff       	jmp    101e68 <__alltraps>

00102060 <vector54>:
.globl vector54
vector54:
  pushl $0
  102060:	6a 00                	push   $0x0
  pushl $54
  102062:	6a 36                	push   $0x36
  jmp __alltraps
  102064:	e9 ff fd ff ff       	jmp    101e68 <__alltraps>

00102069 <vector55>:
.globl vector55
vector55:
  pushl $0
  102069:	6a 00                	push   $0x0
  pushl $55
  10206b:	6a 37                	push   $0x37
  jmp __alltraps
  10206d:	e9 f6 fd ff ff       	jmp    101e68 <__alltraps>

00102072 <vector56>:
.globl vector56
vector56:
  pushl $0
  102072:	6a 00                	push   $0x0
  pushl $56
  102074:	6a 38                	push   $0x38
  jmp __alltraps
  102076:	e9 ed fd ff ff       	jmp    101e68 <__alltraps>

0010207b <vector57>:
.globl vector57
vector57:
  pushl $0
  10207b:	6a 00                	push   $0x0
  pushl $57
  10207d:	6a 39                	push   $0x39
  jmp __alltraps
  10207f:	e9 e4 fd ff ff       	jmp    101e68 <__alltraps>

00102084 <vector58>:
.globl vector58
vector58:
  pushl $0
  102084:	6a 00                	push   $0x0
  pushl $58
  102086:	6a 3a                	push   $0x3a
  jmp __alltraps
  102088:	e9 db fd ff ff       	jmp    101e68 <__alltraps>

0010208d <vector59>:
.globl vector59
vector59:
  pushl $0
  10208d:	6a 00                	push   $0x0
  pushl $59
  10208f:	6a 3b                	push   $0x3b
  jmp __alltraps
  102091:	e9 d2 fd ff ff       	jmp    101e68 <__alltraps>

00102096 <vector60>:
.globl vector60
vector60:
  pushl $0
  102096:	6a 00                	push   $0x0
  pushl $60
  102098:	6a 3c                	push   $0x3c
  jmp __alltraps
  10209a:	e9 c9 fd ff ff       	jmp    101e68 <__alltraps>

0010209f <vector61>:
.globl vector61
vector61:
  pushl $0
  10209f:	6a 00                	push   $0x0
  pushl $61
  1020a1:	6a 3d                	push   $0x3d
  jmp __alltraps
  1020a3:	e9 c0 fd ff ff       	jmp    101e68 <__alltraps>

001020a8 <vector62>:
.globl vector62
vector62:
  pushl $0
  1020a8:	6a 00                	push   $0x0
  pushl $62
  1020aa:	6a 3e                	push   $0x3e
  jmp __alltraps
  1020ac:	e9 b7 fd ff ff       	jmp    101e68 <__alltraps>

001020b1 <vector63>:
.globl vector63
vector63:
  pushl $0
  1020b1:	6a 00                	push   $0x0
  pushl $63
  1020b3:	6a 3f                	push   $0x3f
  jmp __alltraps
  1020b5:	e9 ae fd ff ff       	jmp    101e68 <__alltraps>

001020ba <vector64>:
.globl vector64
vector64:
  pushl $0
  1020ba:	6a 00                	push   $0x0
  pushl $64
  1020bc:	6a 40                	push   $0x40
  jmp __alltraps
  1020be:	e9 a5 fd ff ff       	jmp    101e68 <__alltraps>

001020c3 <vector65>:
.globl vector65
vector65:
  pushl $0
  1020c3:	6a 00                	push   $0x0
  pushl $65
  1020c5:	6a 41                	push   $0x41
  jmp __alltraps
  1020c7:	e9 9c fd ff ff       	jmp    101e68 <__alltraps>

001020cc <vector66>:
.globl vector66
vector66:
  pushl $0
  1020cc:	6a 00                	push   $0x0
  pushl $66
  1020ce:	6a 42                	push   $0x42
  jmp __alltraps
  1020d0:	e9 93 fd ff ff       	jmp    101e68 <__alltraps>

001020d5 <vector67>:
.globl vector67
vector67:
  pushl $0
  1020d5:	6a 00                	push   $0x0
  pushl $67
  1020d7:	6a 43                	push   $0x43
  jmp __alltraps
  1020d9:	e9 8a fd ff ff       	jmp    101e68 <__alltraps>

001020de <vector68>:
.globl vector68
vector68:
  pushl $0
  1020de:	6a 00                	push   $0x0
  pushl $68
  1020e0:	6a 44                	push   $0x44
  jmp __alltraps
  1020e2:	e9 81 fd ff ff       	jmp    101e68 <__alltraps>

001020e7 <vector69>:
.globl vector69
vector69:
  pushl $0
  1020e7:	6a 00                	push   $0x0
  pushl $69
  1020e9:	6a 45                	push   $0x45
  jmp __alltraps
  1020eb:	e9 78 fd ff ff       	jmp    101e68 <__alltraps>

001020f0 <vector70>:
.globl vector70
vector70:
  pushl $0
  1020f0:	6a 00                	push   $0x0
  pushl $70
  1020f2:	6a 46                	push   $0x46
  jmp __alltraps
  1020f4:	e9 6f fd ff ff       	jmp    101e68 <__alltraps>

001020f9 <vector71>:
.globl vector71
vector71:
  pushl $0
  1020f9:	6a 00                	push   $0x0
  pushl $71
  1020fb:	6a 47                	push   $0x47
  jmp __alltraps
  1020fd:	e9 66 fd ff ff       	jmp    101e68 <__alltraps>

00102102 <vector72>:
.globl vector72
vector72:
  pushl $0
  102102:	6a 00                	push   $0x0
  pushl $72
  102104:	6a 48                	push   $0x48
  jmp __alltraps
  102106:	e9 5d fd ff ff       	jmp    101e68 <__alltraps>

0010210b <vector73>:
.globl vector73
vector73:
  pushl $0
  10210b:	6a 00                	push   $0x0
  pushl $73
  10210d:	6a 49                	push   $0x49
  jmp __alltraps
  10210f:	e9 54 fd ff ff       	jmp    101e68 <__alltraps>

00102114 <vector74>:
.globl vector74
vector74:
  pushl $0
  102114:	6a 00                	push   $0x0
  pushl $74
  102116:	6a 4a                	push   $0x4a
  jmp __alltraps
  102118:	e9 4b fd ff ff       	jmp    101e68 <__alltraps>

0010211d <vector75>:
.globl vector75
vector75:
  pushl $0
  10211d:	6a 00                	push   $0x0
  pushl $75
  10211f:	6a 4b                	push   $0x4b
  jmp __alltraps
  102121:	e9 42 fd ff ff       	jmp    101e68 <__alltraps>

00102126 <vector76>:
.globl vector76
vector76:
  pushl $0
  102126:	6a 00                	push   $0x0
  pushl $76
  102128:	6a 4c                	push   $0x4c
  jmp __alltraps
  10212a:	e9 39 fd ff ff       	jmp    101e68 <__alltraps>

0010212f <vector77>:
.globl vector77
vector77:
  pushl $0
  10212f:	6a 00                	push   $0x0
  pushl $77
  102131:	6a 4d                	push   $0x4d
  jmp __alltraps
  102133:	e9 30 fd ff ff       	jmp    101e68 <__alltraps>

00102138 <vector78>:
.globl vector78
vector78:
  pushl $0
  102138:	6a 00                	push   $0x0
  pushl $78
  10213a:	6a 4e                	push   $0x4e
  jmp __alltraps
  10213c:	e9 27 fd ff ff       	jmp    101e68 <__alltraps>

00102141 <vector79>:
.globl vector79
vector79:
  pushl $0
  102141:	6a 00                	push   $0x0
  pushl $79
  102143:	6a 4f                	push   $0x4f
  jmp __alltraps
  102145:	e9 1e fd ff ff       	jmp    101e68 <__alltraps>

0010214a <vector80>:
.globl vector80
vector80:
  pushl $0
  10214a:	6a 00                	push   $0x0
  pushl $80
  10214c:	6a 50                	push   $0x50
  jmp __alltraps
  10214e:	e9 15 fd ff ff       	jmp    101e68 <__alltraps>

00102153 <vector81>:
.globl vector81
vector81:
  pushl $0
  102153:	6a 00                	push   $0x0
  pushl $81
  102155:	6a 51                	push   $0x51
  jmp __alltraps
  102157:	e9 0c fd ff ff       	jmp    101e68 <__alltraps>

0010215c <vector82>:
.globl vector82
vector82:
  pushl $0
  10215c:	6a 00                	push   $0x0
  pushl $82
  10215e:	6a 52                	push   $0x52
  jmp __alltraps
  102160:	e9 03 fd ff ff       	jmp    101e68 <__alltraps>

00102165 <vector83>:
.globl vector83
vector83:
  pushl $0
  102165:	6a 00                	push   $0x0
  pushl $83
  102167:	6a 53                	push   $0x53
  jmp __alltraps
  102169:	e9 fa fc ff ff       	jmp    101e68 <__alltraps>

0010216e <vector84>:
.globl vector84
vector84:
  pushl $0
  10216e:	6a 00                	push   $0x0
  pushl $84
  102170:	6a 54                	push   $0x54
  jmp __alltraps
  102172:	e9 f1 fc ff ff       	jmp    101e68 <__alltraps>

00102177 <vector85>:
.globl vector85
vector85:
  pushl $0
  102177:	6a 00                	push   $0x0
  pushl $85
  102179:	6a 55                	push   $0x55
  jmp __alltraps
  10217b:	e9 e8 fc ff ff       	jmp    101e68 <__alltraps>

00102180 <vector86>:
.globl vector86
vector86:
  pushl $0
  102180:	6a 00                	push   $0x0
  pushl $86
  102182:	6a 56                	push   $0x56
  jmp __alltraps
  102184:	e9 df fc ff ff       	jmp    101e68 <__alltraps>

00102189 <vector87>:
.globl vector87
vector87:
  pushl $0
  102189:	6a 00                	push   $0x0
  pushl $87
  10218b:	6a 57                	push   $0x57
  jmp __alltraps
  10218d:	e9 d6 fc ff ff       	jmp    101e68 <__alltraps>

00102192 <vector88>:
.globl vector88
vector88:
  pushl $0
  102192:	6a 00                	push   $0x0
  pushl $88
  102194:	6a 58                	push   $0x58
  jmp __alltraps
  102196:	e9 cd fc ff ff       	jmp    101e68 <__alltraps>

0010219b <vector89>:
.globl vector89
vector89:
  pushl $0
  10219b:	6a 00                	push   $0x0
  pushl $89
  10219d:	6a 59                	push   $0x59
  jmp __alltraps
  10219f:	e9 c4 fc ff ff       	jmp    101e68 <__alltraps>

001021a4 <vector90>:
.globl vector90
vector90:
  pushl $0
  1021a4:	6a 00                	push   $0x0
  pushl $90
  1021a6:	6a 5a                	push   $0x5a
  jmp __alltraps
  1021a8:	e9 bb fc ff ff       	jmp    101e68 <__alltraps>

001021ad <vector91>:
.globl vector91
vector91:
  pushl $0
  1021ad:	6a 00                	push   $0x0
  pushl $91
  1021af:	6a 5b                	push   $0x5b
  jmp __alltraps
  1021b1:	e9 b2 fc ff ff       	jmp    101e68 <__alltraps>

001021b6 <vector92>:
.globl vector92
vector92:
  pushl $0
  1021b6:	6a 00                	push   $0x0
  pushl $92
  1021b8:	6a 5c                	push   $0x5c
  jmp __alltraps
  1021ba:	e9 a9 fc ff ff       	jmp    101e68 <__alltraps>

001021bf <vector93>:
.globl vector93
vector93:
  pushl $0
  1021bf:	6a 00                	push   $0x0
  pushl $93
  1021c1:	6a 5d                	push   $0x5d
  jmp __alltraps
  1021c3:	e9 a0 fc ff ff       	jmp    101e68 <__alltraps>

001021c8 <vector94>:
.globl vector94
vector94:
  pushl $0
  1021c8:	6a 00                	push   $0x0
  pushl $94
  1021ca:	6a 5e                	push   $0x5e
  jmp __alltraps
  1021cc:	e9 97 fc ff ff       	jmp    101e68 <__alltraps>

001021d1 <vector95>:
.globl vector95
vector95:
  pushl $0
  1021d1:	6a 00                	push   $0x0
  pushl $95
  1021d3:	6a 5f                	push   $0x5f
  jmp __alltraps
  1021d5:	e9 8e fc ff ff       	jmp    101e68 <__alltraps>

001021da <vector96>:
.globl vector96
vector96:
  pushl $0
  1021da:	6a 00                	push   $0x0
  pushl $96
  1021dc:	6a 60                	push   $0x60
  jmp __alltraps
  1021de:	e9 85 fc ff ff       	jmp    101e68 <__alltraps>

001021e3 <vector97>:
.globl vector97
vector97:
  pushl $0
  1021e3:	6a 00                	push   $0x0
  pushl $97
  1021e5:	6a 61                	push   $0x61
  jmp __alltraps
  1021e7:	e9 7c fc ff ff       	jmp    101e68 <__alltraps>

001021ec <vector98>:
.globl vector98
vector98:
  pushl $0
  1021ec:	6a 00                	push   $0x0
  pushl $98
  1021ee:	6a 62                	push   $0x62
  jmp __alltraps
  1021f0:	e9 73 fc ff ff       	jmp    101e68 <__alltraps>

001021f5 <vector99>:
.globl vector99
vector99:
  pushl $0
  1021f5:	6a 00                	push   $0x0
  pushl $99
  1021f7:	6a 63                	push   $0x63
  jmp __alltraps
  1021f9:	e9 6a fc ff ff       	jmp    101e68 <__alltraps>

001021fe <vector100>:
.globl vector100
vector100:
  pushl $0
  1021fe:	6a 00                	push   $0x0
  pushl $100
  102200:	6a 64                	push   $0x64
  jmp __alltraps
  102202:	e9 61 fc ff ff       	jmp    101e68 <__alltraps>

00102207 <vector101>:
.globl vector101
vector101:
  pushl $0
  102207:	6a 00                	push   $0x0
  pushl $101
  102209:	6a 65                	push   $0x65
  jmp __alltraps
  10220b:	e9 58 fc ff ff       	jmp    101e68 <__alltraps>

00102210 <vector102>:
.globl vector102
vector102:
  pushl $0
  102210:	6a 00                	push   $0x0
  pushl $102
  102212:	6a 66                	push   $0x66
  jmp __alltraps
  102214:	e9 4f fc ff ff       	jmp    101e68 <__alltraps>

00102219 <vector103>:
.globl vector103
vector103:
  pushl $0
  102219:	6a 00                	push   $0x0
  pushl $103
  10221b:	6a 67                	push   $0x67
  jmp __alltraps
  10221d:	e9 46 fc ff ff       	jmp    101e68 <__alltraps>

00102222 <vector104>:
.globl vector104
vector104:
  pushl $0
  102222:	6a 00                	push   $0x0
  pushl $104
  102224:	6a 68                	push   $0x68
  jmp __alltraps
  102226:	e9 3d fc ff ff       	jmp    101e68 <__alltraps>

0010222b <vector105>:
.globl vector105
vector105:
  pushl $0
  10222b:	6a 00                	push   $0x0
  pushl $105
  10222d:	6a 69                	push   $0x69
  jmp __alltraps
  10222f:	e9 34 fc ff ff       	jmp    101e68 <__alltraps>

00102234 <vector106>:
.globl vector106
vector106:
  pushl $0
  102234:	6a 00                	push   $0x0
  pushl $106
  102236:	6a 6a                	push   $0x6a
  jmp __alltraps
  102238:	e9 2b fc ff ff       	jmp    101e68 <__alltraps>

0010223d <vector107>:
.globl vector107
vector107:
  pushl $0
  10223d:	6a 00                	push   $0x0
  pushl $107
  10223f:	6a 6b                	push   $0x6b
  jmp __alltraps
  102241:	e9 22 fc ff ff       	jmp    101e68 <__alltraps>

00102246 <vector108>:
.globl vector108
vector108:
  pushl $0
  102246:	6a 00                	push   $0x0
  pushl $108
  102248:	6a 6c                	push   $0x6c
  jmp __alltraps
  10224a:	e9 19 fc ff ff       	jmp    101e68 <__alltraps>

0010224f <vector109>:
.globl vector109
vector109:
  pushl $0
  10224f:	6a 00                	push   $0x0
  pushl $109
  102251:	6a 6d                	push   $0x6d
  jmp __alltraps
  102253:	e9 10 fc ff ff       	jmp    101e68 <__alltraps>

00102258 <vector110>:
.globl vector110
vector110:
  pushl $0
  102258:	6a 00                	push   $0x0
  pushl $110
  10225a:	6a 6e                	push   $0x6e
  jmp __alltraps
  10225c:	e9 07 fc ff ff       	jmp    101e68 <__alltraps>

00102261 <vector111>:
.globl vector111
vector111:
  pushl $0
  102261:	6a 00                	push   $0x0
  pushl $111
  102263:	6a 6f                	push   $0x6f
  jmp __alltraps
  102265:	e9 fe fb ff ff       	jmp    101e68 <__alltraps>

0010226a <vector112>:
.globl vector112
vector112:
  pushl $0
  10226a:	6a 00                	push   $0x0
  pushl $112
  10226c:	6a 70                	push   $0x70
  jmp __alltraps
  10226e:	e9 f5 fb ff ff       	jmp    101e68 <__alltraps>

00102273 <vector113>:
.globl vector113
vector113:
  pushl $0
  102273:	6a 00                	push   $0x0
  pushl $113
  102275:	6a 71                	push   $0x71
  jmp __alltraps
  102277:	e9 ec fb ff ff       	jmp    101e68 <__alltraps>

0010227c <vector114>:
.globl vector114
vector114:
  pushl $0
  10227c:	6a 00                	push   $0x0
  pushl $114
  10227e:	6a 72                	push   $0x72
  jmp __alltraps
  102280:	e9 e3 fb ff ff       	jmp    101e68 <__alltraps>

00102285 <vector115>:
.globl vector115
vector115:
  pushl $0
  102285:	6a 00                	push   $0x0
  pushl $115
  102287:	6a 73                	push   $0x73
  jmp __alltraps
  102289:	e9 da fb ff ff       	jmp    101e68 <__alltraps>

0010228e <vector116>:
.globl vector116
vector116:
  pushl $0
  10228e:	6a 00                	push   $0x0
  pushl $116
  102290:	6a 74                	push   $0x74
  jmp __alltraps
  102292:	e9 d1 fb ff ff       	jmp    101e68 <__alltraps>

00102297 <vector117>:
.globl vector117
vector117:
  pushl $0
  102297:	6a 00                	push   $0x0
  pushl $117
  102299:	6a 75                	push   $0x75
  jmp __alltraps
  10229b:	e9 c8 fb ff ff       	jmp    101e68 <__alltraps>

001022a0 <vector118>:
.globl vector118
vector118:
  pushl $0
  1022a0:	6a 00                	push   $0x0
  pushl $118
  1022a2:	6a 76                	push   $0x76
  jmp __alltraps
  1022a4:	e9 bf fb ff ff       	jmp    101e68 <__alltraps>

001022a9 <vector119>:
.globl vector119
vector119:
  pushl $0
  1022a9:	6a 00                	push   $0x0
  pushl $119
  1022ab:	6a 77                	push   $0x77
  jmp __alltraps
  1022ad:	e9 b6 fb ff ff       	jmp    101e68 <__alltraps>

001022b2 <vector120>:
.globl vector120
vector120:
  pushl $0
  1022b2:	6a 00                	push   $0x0
  pushl $120
  1022b4:	6a 78                	push   $0x78
  jmp __alltraps
  1022b6:	e9 ad fb ff ff       	jmp    101e68 <__alltraps>

001022bb <vector121>:
.globl vector121
vector121:
  pushl $0
  1022bb:	6a 00                	push   $0x0
  pushl $121
  1022bd:	6a 79                	push   $0x79
  jmp __alltraps
  1022bf:	e9 a4 fb ff ff       	jmp    101e68 <__alltraps>

001022c4 <vector122>:
.globl vector122
vector122:
  pushl $0
  1022c4:	6a 00                	push   $0x0
  pushl $122
  1022c6:	6a 7a                	push   $0x7a
  jmp __alltraps
  1022c8:	e9 9b fb ff ff       	jmp    101e68 <__alltraps>

001022cd <vector123>:
.globl vector123
vector123:
  pushl $0
  1022cd:	6a 00                	push   $0x0
  pushl $123
  1022cf:	6a 7b                	push   $0x7b
  jmp __alltraps
  1022d1:	e9 92 fb ff ff       	jmp    101e68 <__alltraps>

001022d6 <vector124>:
.globl vector124
vector124:
  pushl $0
  1022d6:	6a 00                	push   $0x0
  pushl $124
  1022d8:	6a 7c                	push   $0x7c
  jmp __alltraps
  1022da:	e9 89 fb ff ff       	jmp    101e68 <__alltraps>

001022df <vector125>:
.globl vector125
vector125:
  pushl $0
  1022df:	6a 00                	push   $0x0
  pushl $125
  1022e1:	6a 7d                	push   $0x7d
  jmp __alltraps
  1022e3:	e9 80 fb ff ff       	jmp    101e68 <__alltraps>

001022e8 <vector126>:
.globl vector126
vector126:
  pushl $0
  1022e8:	6a 00                	push   $0x0
  pushl $126
  1022ea:	6a 7e                	push   $0x7e
  jmp __alltraps
  1022ec:	e9 77 fb ff ff       	jmp    101e68 <__alltraps>

001022f1 <vector127>:
.globl vector127
vector127:
  pushl $0
  1022f1:	6a 00                	push   $0x0
  pushl $127
  1022f3:	6a 7f                	push   $0x7f
  jmp __alltraps
  1022f5:	e9 6e fb ff ff       	jmp    101e68 <__alltraps>

001022fa <vector128>:
.globl vector128
vector128:
  pushl $0
  1022fa:	6a 00                	push   $0x0
  pushl $128
  1022fc:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102301:	e9 62 fb ff ff       	jmp    101e68 <__alltraps>

00102306 <vector129>:
.globl vector129
vector129:
  pushl $0
  102306:	6a 00                	push   $0x0
  pushl $129
  102308:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  10230d:	e9 56 fb ff ff       	jmp    101e68 <__alltraps>

00102312 <vector130>:
.globl vector130
vector130:
  pushl $0
  102312:	6a 00                	push   $0x0
  pushl $130
  102314:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102319:	e9 4a fb ff ff       	jmp    101e68 <__alltraps>

0010231e <vector131>:
.globl vector131
vector131:
  pushl $0
  10231e:	6a 00                	push   $0x0
  pushl $131
  102320:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102325:	e9 3e fb ff ff       	jmp    101e68 <__alltraps>

0010232a <vector132>:
.globl vector132
vector132:
  pushl $0
  10232a:	6a 00                	push   $0x0
  pushl $132
  10232c:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102331:	e9 32 fb ff ff       	jmp    101e68 <__alltraps>

00102336 <vector133>:
.globl vector133
vector133:
  pushl $0
  102336:	6a 00                	push   $0x0
  pushl $133
  102338:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  10233d:	e9 26 fb ff ff       	jmp    101e68 <__alltraps>

00102342 <vector134>:
.globl vector134
vector134:
  pushl $0
  102342:	6a 00                	push   $0x0
  pushl $134
  102344:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  102349:	e9 1a fb ff ff       	jmp    101e68 <__alltraps>

0010234e <vector135>:
.globl vector135
vector135:
  pushl $0
  10234e:	6a 00                	push   $0x0
  pushl $135
  102350:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  102355:	e9 0e fb ff ff       	jmp    101e68 <__alltraps>

0010235a <vector136>:
.globl vector136
vector136:
  pushl $0
  10235a:	6a 00                	push   $0x0
  pushl $136
  10235c:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102361:	e9 02 fb ff ff       	jmp    101e68 <__alltraps>

00102366 <vector137>:
.globl vector137
vector137:
  pushl $0
  102366:	6a 00                	push   $0x0
  pushl $137
  102368:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  10236d:	e9 f6 fa ff ff       	jmp    101e68 <__alltraps>

00102372 <vector138>:
.globl vector138
vector138:
  pushl $0
  102372:	6a 00                	push   $0x0
  pushl $138
  102374:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  102379:	e9 ea fa ff ff       	jmp    101e68 <__alltraps>

0010237e <vector139>:
.globl vector139
vector139:
  pushl $0
  10237e:	6a 00                	push   $0x0
  pushl $139
  102380:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  102385:	e9 de fa ff ff       	jmp    101e68 <__alltraps>

0010238a <vector140>:
.globl vector140
vector140:
  pushl $0
  10238a:	6a 00                	push   $0x0
  pushl $140
  10238c:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  102391:	e9 d2 fa ff ff       	jmp    101e68 <__alltraps>

00102396 <vector141>:
.globl vector141
vector141:
  pushl $0
  102396:	6a 00                	push   $0x0
  pushl $141
  102398:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  10239d:	e9 c6 fa ff ff       	jmp    101e68 <__alltraps>

001023a2 <vector142>:
.globl vector142
vector142:
  pushl $0
  1023a2:	6a 00                	push   $0x0
  pushl $142
  1023a4:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1023a9:	e9 ba fa ff ff       	jmp    101e68 <__alltraps>

001023ae <vector143>:
.globl vector143
vector143:
  pushl $0
  1023ae:	6a 00                	push   $0x0
  pushl $143
  1023b0:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1023b5:	e9 ae fa ff ff       	jmp    101e68 <__alltraps>

001023ba <vector144>:
.globl vector144
vector144:
  pushl $0
  1023ba:	6a 00                	push   $0x0
  pushl $144
  1023bc:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1023c1:	e9 a2 fa ff ff       	jmp    101e68 <__alltraps>

001023c6 <vector145>:
.globl vector145
vector145:
  pushl $0
  1023c6:	6a 00                	push   $0x0
  pushl $145
  1023c8:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1023cd:	e9 96 fa ff ff       	jmp    101e68 <__alltraps>

001023d2 <vector146>:
.globl vector146
vector146:
  pushl $0
  1023d2:	6a 00                	push   $0x0
  pushl $146
  1023d4:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1023d9:	e9 8a fa ff ff       	jmp    101e68 <__alltraps>

001023de <vector147>:
.globl vector147
vector147:
  pushl $0
  1023de:	6a 00                	push   $0x0
  pushl $147
  1023e0:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  1023e5:	e9 7e fa ff ff       	jmp    101e68 <__alltraps>

001023ea <vector148>:
.globl vector148
vector148:
  pushl $0
  1023ea:	6a 00                	push   $0x0
  pushl $148
  1023ec:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  1023f1:	e9 72 fa ff ff       	jmp    101e68 <__alltraps>

001023f6 <vector149>:
.globl vector149
vector149:
  pushl $0
  1023f6:	6a 00                	push   $0x0
  pushl $149
  1023f8:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  1023fd:	e9 66 fa ff ff       	jmp    101e68 <__alltraps>

00102402 <vector150>:
.globl vector150
vector150:
  pushl $0
  102402:	6a 00                	push   $0x0
  pushl $150
  102404:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102409:	e9 5a fa ff ff       	jmp    101e68 <__alltraps>

0010240e <vector151>:
.globl vector151
vector151:
  pushl $0
  10240e:	6a 00                	push   $0x0
  pushl $151
  102410:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102415:	e9 4e fa ff ff       	jmp    101e68 <__alltraps>

0010241a <vector152>:
.globl vector152
vector152:
  pushl $0
  10241a:	6a 00                	push   $0x0
  pushl $152
  10241c:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102421:	e9 42 fa ff ff       	jmp    101e68 <__alltraps>

00102426 <vector153>:
.globl vector153
vector153:
  pushl $0
  102426:	6a 00                	push   $0x0
  pushl $153
  102428:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  10242d:	e9 36 fa ff ff       	jmp    101e68 <__alltraps>

00102432 <vector154>:
.globl vector154
vector154:
  pushl $0
  102432:	6a 00                	push   $0x0
  pushl $154
  102434:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  102439:	e9 2a fa ff ff       	jmp    101e68 <__alltraps>

0010243e <vector155>:
.globl vector155
vector155:
  pushl $0
  10243e:	6a 00                	push   $0x0
  pushl $155
  102440:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  102445:	e9 1e fa ff ff       	jmp    101e68 <__alltraps>

0010244a <vector156>:
.globl vector156
vector156:
  pushl $0
  10244a:	6a 00                	push   $0x0
  pushl $156
  10244c:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102451:	e9 12 fa ff ff       	jmp    101e68 <__alltraps>

00102456 <vector157>:
.globl vector157
vector157:
  pushl $0
  102456:	6a 00                	push   $0x0
  pushl $157
  102458:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  10245d:	e9 06 fa ff ff       	jmp    101e68 <__alltraps>

00102462 <vector158>:
.globl vector158
vector158:
  pushl $0
  102462:	6a 00                	push   $0x0
  pushl $158
  102464:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  102469:	e9 fa f9 ff ff       	jmp    101e68 <__alltraps>

0010246e <vector159>:
.globl vector159
vector159:
  pushl $0
  10246e:	6a 00                	push   $0x0
  pushl $159
  102470:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  102475:	e9 ee f9 ff ff       	jmp    101e68 <__alltraps>

0010247a <vector160>:
.globl vector160
vector160:
  pushl $0
  10247a:	6a 00                	push   $0x0
  pushl $160
  10247c:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  102481:	e9 e2 f9 ff ff       	jmp    101e68 <__alltraps>

00102486 <vector161>:
.globl vector161
vector161:
  pushl $0
  102486:	6a 00                	push   $0x0
  pushl $161
  102488:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  10248d:	e9 d6 f9 ff ff       	jmp    101e68 <__alltraps>

00102492 <vector162>:
.globl vector162
vector162:
  pushl $0
  102492:	6a 00                	push   $0x0
  pushl $162
  102494:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102499:	e9 ca f9 ff ff       	jmp    101e68 <__alltraps>

0010249e <vector163>:
.globl vector163
vector163:
  pushl $0
  10249e:	6a 00                	push   $0x0
  pushl $163
  1024a0:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1024a5:	e9 be f9 ff ff       	jmp    101e68 <__alltraps>

001024aa <vector164>:
.globl vector164
vector164:
  pushl $0
  1024aa:	6a 00                	push   $0x0
  pushl $164
  1024ac:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1024b1:	e9 b2 f9 ff ff       	jmp    101e68 <__alltraps>

001024b6 <vector165>:
.globl vector165
vector165:
  pushl $0
  1024b6:	6a 00                	push   $0x0
  pushl $165
  1024b8:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1024bd:	e9 a6 f9 ff ff       	jmp    101e68 <__alltraps>

001024c2 <vector166>:
.globl vector166
vector166:
  pushl $0
  1024c2:	6a 00                	push   $0x0
  pushl $166
  1024c4:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1024c9:	e9 9a f9 ff ff       	jmp    101e68 <__alltraps>

001024ce <vector167>:
.globl vector167
vector167:
  pushl $0
  1024ce:	6a 00                	push   $0x0
  pushl $167
  1024d0:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1024d5:	e9 8e f9 ff ff       	jmp    101e68 <__alltraps>

001024da <vector168>:
.globl vector168
vector168:
  pushl $0
  1024da:	6a 00                	push   $0x0
  pushl $168
  1024dc:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  1024e1:	e9 82 f9 ff ff       	jmp    101e68 <__alltraps>

001024e6 <vector169>:
.globl vector169
vector169:
  pushl $0
  1024e6:	6a 00                	push   $0x0
  pushl $169
  1024e8:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  1024ed:	e9 76 f9 ff ff       	jmp    101e68 <__alltraps>

001024f2 <vector170>:
.globl vector170
vector170:
  pushl $0
  1024f2:	6a 00                	push   $0x0
  pushl $170
  1024f4:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  1024f9:	e9 6a f9 ff ff       	jmp    101e68 <__alltraps>

001024fe <vector171>:
.globl vector171
vector171:
  pushl $0
  1024fe:	6a 00                	push   $0x0
  pushl $171
  102500:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102505:	e9 5e f9 ff ff       	jmp    101e68 <__alltraps>

0010250a <vector172>:
.globl vector172
vector172:
  pushl $0
  10250a:	6a 00                	push   $0x0
  pushl $172
  10250c:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102511:	e9 52 f9 ff ff       	jmp    101e68 <__alltraps>

00102516 <vector173>:
.globl vector173
vector173:
  pushl $0
  102516:	6a 00                	push   $0x0
  pushl $173
  102518:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  10251d:	e9 46 f9 ff ff       	jmp    101e68 <__alltraps>

00102522 <vector174>:
.globl vector174
vector174:
  pushl $0
  102522:	6a 00                	push   $0x0
  pushl $174
  102524:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102529:	e9 3a f9 ff ff       	jmp    101e68 <__alltraps>

0010252e <vector175>:
.globl vector175
vector175:
  pushl $0
  10252e:	6a 00                	push   $0x0
  pushl $175
  102530:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  102535:	e9 2e f9 ff ff       	jmp    101e68 <__alltraps>

0010253a <vector176>:
.globl vector176
vector176:
  pushl $0
  10253a:	6a 00                	push   $0x0
  pushl $176
  10253c:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102541:	e9 22 f9 ff ff       	jmp    101e68 <__alltraps>

00102546 <vector177>:
.globl vector177
vector177:
  pushl $0
  102546:	6a 00                	push   $0x0
  pushl $177
  102548:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  10254d:	e9 16 f9 ff ff       	jmp    101e68 <__alltraps>

00102552 <vector178>:
.globl vector178
vector178:
  pushl $0
  102552:	6a 00                	push   $0x0
  pushl $178
  102554:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  102559:	e9 0a f9 ff ff       	jmp    101e68 <__alltraps>

0010255e <vector179>:
.globl vector179
vector179:
  pushl $0
  10255e:	6a 00                	push   $0x0
  pushl $179
  102560:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  102565:	e9 fe f8 ff ff       	jmp    101e68 <__alltraps>

0010256a <vector180>:
.globl vector180
vector180:
  pushl $0
  10256a:	6a 00                	push   $0x0
  pushl $180
  10256c:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102571:	e9 f2 f8 ff ff       	jmp    101e68 <__alltraps>

00102576 <vector181>:
.globl vector181
vector181:
  pushl $0
  102576:	6a 00                	push   $0x0
  pushl $181
  102578:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  10257d:	e9 e6 f8 ff ff       	jmp    101e68 <__alltraps>

00102582 <vector182>:
.globl vector182
vector182:
  pushl $0
  102582:	6a 00                	push   $0x0
  pushl $182
  102584:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  102589:	e9 da f8 ff ff       	jmp    101e68 <__alltraps>

0010258e <vector183>:
.globl vector183
vector183:
  pushl $0
  10258e:	6a 00                	push   $0x0
  pushl $183
  102590:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102595:	e9 ce f8 ff ff       	jmp    101e68 <__alltraps>

0010259a <vector184>:
.globl vector184
vector184:
  pushl $0
  10259a:	6a 00                	push   $0x0
  pushl $184
  10259c:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1025a1:	e9 c2 f8 ff ff       	jmp    101e68 <__alltraps>

001025a6 <vector185>:
.globl vector185
vector185:
  pushl $0
  1025a6:	6a 00                	push   $0x0
  pushl $185
  1025a8:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1025ad:	e9 b6 f8 ff ff       	jmp    101e68 <__alltraps>

001025b2 <vector186>:
.globl vector186
vector186:
  pushl $0
  1025b2:	6a 00                	push   $0x0
  pushl $186
  1025b4:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1025b9:	e9 aa f8 ff ff       	jmp    101e68 <__alltraps>

001025be <vector187>:
.globl vector187
vector187:
  pushl $0
  1025be:	6a 00                	push   $0x0
  pushl $187
  1025c0:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1025c5:	e9 9e f8 ff ff       	jmp    101e68 <__alltraps>

001025ca <vector188>:
.globl vector188
vector188:
  pushl $0
  1025ca:	6a 00                	push   $0x0
  pushl $188
  1025cc:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1025d1:	e9 92 f8 ff ff       	jmp    101e68 <__alltraps>

001025d6 <vector189>:
.globl vector189
vector189:
  pushl $0
  1025d6:	6a 00                	push   $0x0
  pushl $189
  1025d8:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  1025dd:	e9 86 f8 ff ff       	jmp    101e68 <__alltraps>

001025e2 <vector190>:
.globl vector190
vector190:
  pushl $0
  1025e2:	6a 00                	push   $0x0
  pushl $190
  1025e4:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  1025e9:	e9 7a f8 ff ff       	jmp    101e68 <__alltraps>

001025ee <vector191>:
.globl vector191
vector191:
  pushl $0
  1025ee:	6a 00                	push   $0x0
  pushl $191
  1025f0:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  1025f5:	e9 6e f8 ff ff       	jmp    101e68 <__alltraps>

001025fa <vector192>:
.globl vector192
vector192:
  pushl $0
  1025fa:	6a 00                	push   $0x0
  pushl $192
  1025fc:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102601:	e9 62 f8 ff ff       	jmp    101e68 <__alltraps>

00102606 <vector193>:
.globl vector193
vector193:
  pushl $0
  102606:	6a 00                	push   $0x0
  pushl $193
  102608:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  10260d:	e9 56 f8 ff ff       	jmp    101e68 <__alltraps>

00102612 <vector194>:
.globl vector194
vector194:
  pushl $0
  102612:	6a 00                	push   $0x0
  pushl $194
  102614:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102619:	e9 4a f8 ff ff       	jmp    101e68 <__alltraps>

0010261e <vector195>:
.globl vector195
vector195:
  pushl $0
  10261e:	6a 00                	push   $0x0
  pushl $195
  102620:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102625:	e9 3e f8 ff ff       	jmp    101e68 <__alltraps>

0010262a <vector196>:
.globl vector196
vector196:
  pushl $0
  10262a:	6a 00                	push   $0x0
  pushl $196
  10262c:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102631:	e9 32 f8 ff ff       	jmp    101e68 <__alltraps>

00102636 <vector197>:
.globl vector197
vector197:
  pushl $0
  102636:	6a 00                	push   $0x0
  pushl $197
  102638:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  10263d:	e9 26 f8 ff ff       	jmp    101e68 <__alltraps>

00102642 <vector198>:
.globl vector198
vector198:
  pushl $0
  102642:	6a 00                	push   $0x0
  pushl $198
  102644:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  102649:	e9 1a f8 ff ff       	jmp    101e68 <__alltraps>

0010264e <vector199>:
.globl vector199
vector199:
  pushl $0
  10264e:	6a 00                	push   $0x0
  pushl $199
  102650:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  102655:	e9 0e f8 ff ff       	jmp    101e68 <__alltraps>

0010265a <vector200>:
.globl vector200
vector200:
  pushl $0
  10265a:	6a 00                	push   $0x0
  pushl $200
  10265c:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102661:	e9 02 f8 ff ff       	jmp    101e68 <__alltraps>

00102666 <vector201>:
.globl vector201
vector201:
  pushl $0
  102666:	6a 00                	push   $0x0
  pushl $201
  102668:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  10266d:	e9 f6 f7 ff ff       	jmp    101e68 <__alltraps>

00102672 <vector202>:
.globl vector202
vector202:
  pushl $0
  102672:	6a 00                	push   $0x0
  pushl $202
  102674:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  102679:	e9 ea f7 ff ff       	jmp    101e68 <__alltraps>

0010267e <vector203>:
.globl vector203
vector203:
  pushl $0
  10267e:	6a 00                	push   $0x0
  pushl $203
  102680:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  102685:	e9 de f7 ff ff       	jmp    101e68 <__alltraps>

0010268a <vector204>:
.globl vector204
vector204:
  pushl $0
  10268a:	6a 00                	push   $0x0
  pushl $204
  10268c:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  102691:	e9 d2 f7 ff ff       	jmp    101e68 <__alltraps>

00102696 <vector205>:
.globl vector205
vector205:
  pushl $0
  102696:	6a 00                	push   $0x0
  pushl $205
  102698:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  10269d:	e9 c6 f7 ff ff       	jmp    101e68 <__alltraps>

001026a2 <vector206>:
.globl vector206
vector206:
  pushl $0
  1026a2:	6a 00                	push   $0x0
  pushl $206
  1026a4:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1026a9:	e9 ba f7 ff ff       	jmp    101e68 <__alltraps>

001026ae <vector207>:
.globl vector207
vector207:
  pushl $0
  1026ae:	6a 00                	push   $0x0
  pushl $207
  1026b0:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1026b5:	e9 ae f7 ff ff       	jmp    101e68 <__alltraps>

001026ba <vector208>:
.globl vector208
vector208:
  pushl $0
  1026ba:	6a 00                	push   $0x0
  pushl $208
  1026bc:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1026c1:	e9 a2 f7 ff ff       	jmp    101e68 <__alltraps>

001026c6 <vector209>:
.globl vector209
vector209:
  pushl $0
  1026c6:	6a 00                	push   $0x0
  pushl $209
  1026c8:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1026cd:	e9 96 f7 ff ff       	jmp    101e68 <__alltraps>

001026d2 <vector210>:
.globl vector210
vector210:
  pushl $0
  1026d2:	6a 00                	push   $0x0
  pushl $210
  1026d4:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1026d9:	e9 8a f7 ff ff       	jmp    101e68 <__alltraps>

001026de <vector211>:
.globl vector211
vector211:
  pushl $0
  1026de:	6a 00                	push   $0x0
  pushl $211
  1026e0:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  1026e5:	e9 7e f7 ff ff       	jmp    101e68 <__alltraps>

001026ea <vector212>:
.globl vector212
vector212:
  pushl $0
  1026ea:	6a 00                	push   $0x0
  pushl $212
  1026ec:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  1026f1:	e9 72 f7 ff ff       	jmp    101e68 <__alltraps>

001026f6 <vector213>:
.globl vector213
vector213:
  pushl $0
  1026f6:	6a 00                	push   $0x0
  pushl $213
  1026f8:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  1026fd:	e9 66 f7 ff ff       	jmp    101e68 <__alltraps>

00102702 <vector214>:
.globl vector214
vector214:
  pushl $0
  102702:	6a 00                	push   $0x0
  pushl $214
  102704:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102709:	e9 5a f7 ff ff       	jmp    101e68 <__alltraps>

0010270e <vector215>:
.globl vector215
vector215:
  pushl $0
  10270e:	6a 00                	push   $0x0
  pushl $215
  102710:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102715:	e9 4e f7 ff ff       	jmp    101e68 <__alltraps>

0010271a <vector216>:
.globl vector216
vector216:
  pushl $0
  10271a:	6a 00                	push   $0x0
  pushl $216
  10271c:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102721:	e9 42 f7 ff ff       	jmp    101e68 <__alltraps>

00102726 <vector217>:
.globl vector217
vector217:
  pushl $0
  102726:	6a 00                	push   $0x0
  pushl $217
  102728:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  10272d:	e9 36 f7 ff ff       	jmp    101e68 <__alltraps>

00102732 <vector218>:
.globl vector218
vector218:
  pushl $0
  102732:	6a 00                	push   $0x0
  pushl $218
  102734:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  102739:	e9 2a f7 ff ff       	jmp    101e68 <__alltraps>

0010273e <vector219>:
.globl vector219
vector219:
  pushl $0
  10273e:	6a 00                	push   $0x0
  pushl $219
  102740:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  102745:	e9 1e f7 ff ff       	jmp    101e68 <__alltraps>

0010274a <vector220>:
.globl vector220
vector220:
  pushl $0
  10274a:	6a 00                	push   $0x0
  pushl $220
  10274c:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102751:	e9 12 f7 ff ff       	jmp    101e68 <__alltraps>

00102756 <vector221>:
.globl vector221
vector221:
  pushl $0
  102756:	6a 00                	push   $0x0
  pushl $221
  102758:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  10275d:	e9 06 f7 ff ff       	jmp    101e68 <__alltraps>

00102762 <vector222>:
.globl vector222
vector222:
  pushl $0
  102762:	6a 00                	push   $0x0
  pushl $222
  102764:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  102769:	e9 fa f6 ff ff       	jmp    101e68 <__alltraps>

0010276e <vector223>:
.globl vector223
vector223:
  pushl $0
  10276e:	6a 00                	push   $0x0
  pushl $223
  102770:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  102775:	e9 ee f6 ff ff       	jmp    101e68 <__alltraps>

0010277a <vector224>:
.globl vector224
vector224:
  pushl $0
  10277a:	6a 00                	push   $0x0
  pushl $224
  10277c:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  102781:	e9 e2 f6 ff ff       	jmp    101e68 <__alltraps>

00102786 <vector225>:
.globl vector225
vector225:
  pushl $0
  102786:	6a 00                	push   $0x0
  pushl $225
  102788:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  10278d:	e9 d6 f6 ff ff       	jmp    101e68 <__alltraps>

00102792 <vector226>:
.globl vector226
vector226:
  pushl $0
  102792:	6a 00                	push   $0x0
  pushl $226
  102794:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102799:	e9 ca f6 ff ff       	jmp    101e68 <__alltraps>

0010279e <vector227>:
.globl vector227
vector227:
  pushl $0
  10279e:	6a 00                	push   $0x0
  pushl $227
  1027a0:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1027a5:	e9 be f6 ff ff       	jmp    101e68 <__alltraps>

001027aa <vector228>:
.globl vector228
vector228:
  pushl $0
  1027aa:	6a 00                	push   $0x0
  pushl $228
  1027ac:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1027b1:	e9 b2 f6 ff ff       	jmp    101e68 <__alltraps>

001027b6 <vector229>:
.globl vector229
vector229:
  pushl $0
  1027b6:	6a 00                	push   $0x0
  pushl $229
  1027b8:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1027bd:	e9 a6 f6 ff ff       	jmp    101e68 <__alltraps>

001027c2 <vector230>:
.globl vector230
vector230:
  pushl $0
  1027c2:	6a 00                	push   $0x0
  pushl $230
  1027c4:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1027c9:	e9 9a f6 ff ff       	jmp    101e68 <__alltraps>

001027ce <vector231>:
.globl vector231
vector231:
  pushl $0
  1027ce:	6a 00                	push   $0x0
  pushl $231
  1027d0:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1027d5:	e9 8e f6 ff ff       	jmp    101e68 <__alltraps>

001027da <vector232>:
.globl vector232
vector232:
  pushl $0
  1027da:	6a 00                	push   $0x0
  pushl $232
  1027dc:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  1027e1:	e9 82 f6 ff ff       	jmp    101e68 <__alltraps>

001027e6 <vector233>:
.globl vector233
vector233:
  pushl $0
  1027e6:	6a 00                	push   $0x0
  pushl $233
  1027e8:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  1027ed:	e9 76 f6 ff ff       	jmp    101e68 <__alltraps>

001027f2 <vector234>:
.globl vector234
vector234:
  pushl $0
  1027f2:	6a 00                	push   $0x0
  pushl $234
  1027f4:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  1027f9:	e9 6a f6 ff ff       	jmp    101e68 <__alltraps>

001027fe <vector235>:
.globl vector235
vector235:
  pushl $0
  1027fe:	6a 00                	push   $0x0
  pushl $235
  102800:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102805:	e9 5e f6 ff ff       	jmp    101e68 <__alltraps>

0010280a <vector236>:
.globl vector236
vector236:
  pushl $0
  10280a:	6a 00                	push   $0x0
  pushl $236
  10280c:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102811:	e9 52 f6 ff ff       	jmp    101e68 <__alltraps>

00102816 <vector237>:
.globl vector237
vector237:
  pushl $0
  102816:	6a 00                	push   $0x0
  pushl $237
  102818:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  10281d:	e9 46 f6 ff ff       	jmp    101e68 <__alltraps>

00102822 <vector238>:
.globl vector238
vector238:
  pushl $0
  102822:	6a 00                	push   $0x0
  pushl $238
  102824:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102829:	e9 3a f6 ff ff       	jmp    101e68 <__alltraps>

0010282e <vector239>:
.globl vector239
vector239:
  pushl $0
  10282e:	6a 00                	push   $0x0
  pushl $239
  102830:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  102835:	e9 2e f6 ff ff       	jmp    101e68 <__alltraps>

0010283a <vector240>:
.globl vector240
vector240:
  pushl $0
  10283a:	6a 00                	push   $0x0
  pushl $240
  10283c:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102841:	e9 22 f6 ff ff       	jmp    101e68 <__alltraps>

00102846 <vector241>:
.globl vector241
vector241:
  pushl $0
  102846:	6a 00                	push   $0x0
  pushl $241
  102848:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  10284d:	e9 16 f6 ff ff       	jmp    101e68 <__alltraps>

00102852 <vector242>:
.globl vector242
vector242:
  pushl $0
  102852:	6a 00                	push   $0x0
  pushl $242
  102854:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  102859:	e9 0a f6 ff ff       	jmp    101e68 <__alltraps>

0010285e <vector243>:
.globl vector243
vector243:
  pushl $0
  10285e:	6a 00                	push   $0x0
  pushl $243
  102860:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  102865:	e9 fe f5 ff ff       	jmp    101e68 <__alltraps>

0010286a <vector244>:
.globl vector244
vector244:
  pushl $0
  10286a:	6a 00                	push   $0x0
  pushl $244
  10286c:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102871:	e9 f2 f5 ff ff       	jmp    101e68 <__alltraps>

00102876 <vector245>:
.globl vector245
vector245:
  pushl $0
  102876:	6a 00                	push   $0x0
  pushl $245
  102878:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  10287d:	e9 e6 f5 ff ff       	jmp    101e68 <__alltraps>

00102882 <vector246>:
.globl vector246
vector246:
  pushl $0
  102882:	6a 00                	push   $0x0
  pushl $246
  102884:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  102889:	e9 da f5 ff ff       	jmp    101e68 <__alltraps>

0010288e <vector247>:
.globl vector247
vector247:
  pushl $0
  10288e:	6a 00                	push   $0x0
  pushl $247
  102890:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102895:	e9 ce f5 ff ff       	jmp    101e68 <__alltraps>

0010289a <vector248>:
.globl vector248
vector248:
  pushl $0
  10289a:	6a 00                	push   $0x0
  pushl $248
  10289c:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1028a1:	e9 c2 f5 ff ff       	jmp    101e68 <__alltraps>

001028a6 <vector249>:
.globl vector249
vector249:
  pushl $0
  1028a6:	6a 00                	push   $0x0
  pushl $249
  1028a8:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1028ad:	e9 b6 f5 ff ff       	jmp    101e68 <__alltraps>

001028b2 <vector250>:
.globl vector250
vector250:
  pushl $0
  1028b2:	6a 00                	push   $0x0
  pushl $250
  1028b4:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1028b9:	e9 aa f5 ff ff       	jmp    101e68 <__alltraps>

001028be <vector251>:
.globl vector251
vector251:
  pushl $0
  1028be:	6a 00                	push   $0x0
  pushl $251
  1028c0:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1028c5:	e9 9e f5 ff ff       	jmp    101e68 <__alltraps>

001028ca <vector252>:
.globl vector252
vector252:
  pushl $0
  1028ca:	6a 00                	push   $0x0
  pushl $252
  1028cc:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1028d1:	e9 92 f5 ff ff       	jmp    101e68 <__alltraps>

001028d6 <vector253>:
.globl vector253
vector253:
  pushl $0
  1028d6:	6a 00                	push   $0x0
  pushl $253
  1028d8:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  1028dd:	e9 86 f5 ff ff       	jmp    101e68 <__alltraps>

001028e2 <vector254>:
.globl vector254
vector254:
  pushl $0
  1028e2:	6a 00                	push   $0x0
  pushl $254
  1028e4:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  1028e9:	e9 7a f5 ff ff       	jmp    101e68 <__alltraps>

001028ee <vector255>:
.globl vector255
vector255:
  pushl $0
  1028ee:	6a 00                	push   $0x0
  pushl $255
  1028f0:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  1028f5:	e9 6e f5 ff ff       	jmp    101e68 <__alltraps>

001028fa <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  1028fa:	55                   	push   %ebp
  1028fb:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  1028fd:	8b 45 08             	mov    0x8(%ebp),%eax
  102900:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102903:	b8 23 00 00 00       	mov    $0x23,%eax
  102908:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  10290a:	b8 23 00 00 00       	mov    $0x23,%eax
  10290f:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102911:	b8 10 00 00 00       	mov    $0x10,%eax
  102916:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  102918:	b8 10 00 00 00       	mov    $0x10,%eax
  10291d:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  10291f:	b8 10 00 00 00       	mov    $0x10,%eax
  102924:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  102926:	ea 2d 29 10 00 08 00 	ljmp   $0x8,$0x10292d
}
  10292d:	5d                   	pop    %ebp
  10292e:	c3                   	ret    

0010292f <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  10292f:	55                   	push   %ebp
  102930:	89 e5                	mov    %esp,%ebp
  102932:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  102935:	b8 80 f9 10 00       	mov    $0x10f980,%eax
  10293a:	05 00 04 00 00       	add    $0x400,%eax
  10293f:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  102944:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  10294b:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  10294d:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  102954:	68 00 
  102956:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  10295b:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  102961:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102966:	c1 e8 10             	shr    $0x10,%eax
  102969:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  10296e:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102975:	83 e0 f0             	and    $0xfffffff0,%eax
  102978:	83 c8 09             	or     $0x9,%eax
  10297b:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102980:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102987:	83 c8 10             	or     $0x10,%eax
  10298a:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  10298f:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102996:	83 e0 9f             	and    $0xffffff9f,%eax
  102999:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  10299e:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1029a5:	83 c8 80             	or     $0xffffff80,%eax
  1029a8:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1029ad:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1029b4:	83 e0 f0             	and    $0xfffffff0,%eax
  1029b7:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1029bc:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1029c3:	83 e0 ef             	and    $0xffffffef,%eax
  1029c6:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1029cb:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1029d2:	83 e0 df             	and    $0xffffffdf,%eax
  1029d5:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1029da:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1029e1:	83 c8 40             	or     $0x40,%eax
  1029e4:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1029e9:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1029f0:	83 e0 7f             	and    $0x7f,%eax
  1029f3:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1029f8:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1029fd:	c1 e8 18             	shr    $0x18,%eax
  102a00:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  102a05:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a0c:	83 e0 ef             	and    $0xffffffef,%eax
  102a0f:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102a14:	c7 04 24 10 ea 10 00 	movl   $0x10ea10,(%esp)
  102a1b:	e8 da fe ff ff       	call   1028fa <lgdt>
  102a20:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("cli");
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102a26:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102a2a:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102a2d:	c9                   	leave  
  102a2e:	c3                   	ret    

00102a2f <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102a2f:	55                   	push   %ebp
  102a30:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102a32:	e8 f8 fe ff ff       	call   10292f <gdt_init>
}
  102a37:	5d                   	pop    %ebp
  102a38:	c3                   	ret    

00102a39 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102a39:	55                   	push   %ebp
  102a3a:	89 e5                	mov    %esp,%ebp
  102a3c:	83 ec 58             	sub    $0x58,%esp
  102a3f:	8b 45 10             	mov    0x10(%ebp),%eax
  102a42:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102a45:	8b 45 14             	mov    0x14(%ebp),%eax
  102a48:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102a4b:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102a4e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102a51:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102a54:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102a57:	8b 45 18             	mov    0x18(%ebp),%eax
  102a5a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102a5d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102a60:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102a63:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102a66:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102a69:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102a6f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102a73:	74 1c                	je     102a91 <printnum+0x58>
  102a75:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a78:	ba 00 00 00 00       	mov    $0x0,%edx
  102a7d:	f7 75 e4             	divl   -0x1c(%ebp)
  102a80:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a86:	ba 00 00 00 00       	mov    $0x0,%edx
  102a8b:	f7 75 e4             	divl   -0x1c(%ebp)
  102a8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102a91:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102a94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102a97:	f7 75 e4             	divl   -0x1c(%ebp)
  102a9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102a9d:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102aa0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102aa3:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102aa6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102aa9:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102aac:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102aaf:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102ab2:	8b 45 18             	mov    0x18(%ebp),%eax
  102ab5:	ba 00 00 00 00       	mov    $0x0,%edx
  102aba:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102abd:	77 56                	ja     102b15 <printnum+0xdc>
  102abf:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102ac2:	72 05                	jb     102ac9 <printnum+0x90>
  102ac4:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  102ac7:	77 4c                	ja     102b15 <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
  102ac9:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102acc:	8d 50 ff             	lea    -0x1(%eax),%edx
  102acf:	8b 45 20             	mov    0x20(%ebp),%eax
  102ad2:	89 44 24 18          	mov    %eax,0x18(%esp)
  102ad6:	89 54 24 14          	mov    %edx,0x14(%esp)
  102ada:	8b 45 18             	mov    0x18(%ebp),%eax
  102add:	89 44 24 10          	mov    %eax,0x10(%esp)
  102ae1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102ae4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102ae7:	89 44 24 08          	mov    %eax,0x8(%esp)
  102aeb:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102aef:	8b 45 0c             	mov    0xc(%ebp),%eax
  102af2:	89 44 24 04          	mov    %eax,0x4(%esp)
  102af6:	8b 45 08             	mov    0x8(%ebp),%eax
  102af9:	89 04 24             	mov    %eax,(%esp)
  102afc:	e8 38 ff ff ff       	call   102a39 <printnum>
  102b01:	eb 1c                	jmp    102b1f <printnum+0xe6>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102b03:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b06:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b0a:	8b 45 20             	mov    0x20(%ebp),%eax
  102b0d:	89 04 24             	mov    %eax,(%esp)
  102b10:	8b 45 08             	mov    0x8(%ebp),%eax
  102b13:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  102b15:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  102b19:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102b1d:	7f e4                	jg     102b03 <printnum+0xca>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102b1f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102b22:	05 10 3d 10 00       	add    $0x103d10,%eax
  102b27:	0f b6 00             	movzbl (%eax),%eax
  102b2a:	0f be c0             	movsbl %al,%eax
  102b2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  102b30:	89 54 24 04          	mov    %edx,0x4(%esp)
  102b34:	89 04 24             	mov    %eax,(%esp)
  102b37:	8b 45 08             	mov    0x8(%ebp),%eax
  102b3a:	ff d0                	call   *%eax
}
  102b3c:	c9                   	leave  
  102b3d:	c3                   	ret    

00102b3e <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102b3e:	55                   	push   %ebp
  102b3f:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102b41:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102b45:	7e 14                	jle    102b5b <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102b47:	8b 45 08             	mov    0x8(%ebp),%eax
  102b4a:	8b 00                	mov    (%eax),%eax
  102b4c:	8d 48 08             	lea    0x8(%eax),%ecx
  102b4f:	8b 55 08             	mov    0x8(%ebp),%edx
  102b52:	89 0a                	mov    %ecx,(%edx)
  102b54:	8b 50 04             	mov    0x4(%eax),%edx
  102b57:	8b 00                	mov    (%eax),%eax
  102b59:	eb 30                	jmp    102b8b <getuint+0x4d>
    }
    else if (lflag) {
  102b5b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102b5f:	74 16                	je     102b77 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102b61:	8b 45 08             	mov    0x8(%ebp),%eax
  102b64:	8b 00                	mov    (%eax),%eax
  102b66:	8d 48 04             	lea    0x4(%eax),%ecx
  102b69:	8b 55 08             	mov    0x8(%ebp),%edx
  102b6c:	89 0a                	mov    %ecx,(%edx)
  102b6e:	8b 00                	mov    (%eax),%eax
  102b70:	ba 00 00 00 00       	mov    $0x0,%edx
  102b75:	eb 14                	jmp    102b8b <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102b77:	8b 45 08             	mov    0x8(%ebp),%eax
  102b7a:	8b 00                	mov    (%eax),%eax
  102b7c:	8d 48 04             	lea    0x4(%eax),%ecx
  102b7f:	8b 55 08             	mov    0x8(%ebp),%edx
  102b82:	89 0a                	mov    %ecx,(%edx)
  102b84:	8b 00                	mov    (%eax),%eax
  102b86:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102b8b:	5d                   	pop    %ebp
  102b8c:	c3                   	ret    

00102b8d <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102b8d:	55                   	push   %ebp
  102b8e:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102b90:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102b94:	7e 14                	jle    102baa <getint+0x1d>
        return va_arg(*ap, long long);
  102b96:	8b 45 08             	mov    0x8(%ebp),%eax
  102b99:	8b 00                	mov    (%eax),%eax
  102b9b:	8d 48 08             	lea    0x8(%eax),%ecx
  102b9e:	8b 55 08             	mov    0x8(%ebp),%edx
  102ba1:	89 0a                	mov    %ecx,(%edx)
  102ba3:	8b 50 04             	mov    0x4(%eax),%edx
  102ba6:	8b 00                	mov    (%eax),%eax
  102ba8:	eb 28                	jmp    102bd2 <getint+0x45>
    }
    else if (lflag) {
  102baa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102bae:	74 12                	je     102bc2 <getint+0x35>
        return va_arg(*ap, long);
  102bb0:	8b 45 08             	mov    0x8(%ebp),%eax
  102bb3:	8b 00                	mov    (%eax),%eax
  102bb5:	8d 48 04             	lea    0x4(%eax),%ecx
  102bb8:	8b 55 08             	mov    0x8(%ebp),%edx
  102bbb:	89 0a                	mov    %ecx,(%edx)
  102bbd:	8b 00                	mov    (%eax),%eax
  102bbf:	99                   	cltd   
  102bc0:	eb 10                	jmp    102bd2 <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  102bc5:	8b 00                	mov    (%eax),%eax
  102bc7:	8d 48 04             	lea    0x4(%eax),%ecx
  102bca:	8b 55 08             	mov    0x8(%ebp),%edx
  102bcd:	89 0a                	mov    %ecx,(%edx)
  102bcf:	8b 00                	mov    (%eax),%eax
  102bd1:	99                   	cltd   
    }
}
  102bd2:	5d                   	pop    %ebp
  102bd3:	c3                   	ret    

00102bd4 <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  102bd4:	55                   	push   %ebp
  102bd5:	89 e5                	mov    %esp,%ebp
  102bd7:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  102bda:	8d 45 14             	lea    0x14(%ebp),%eax
  102bdd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  102be0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102be3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102be7:	8b 45 10             	mov    0x10(%ebp),%eax
  102bea:	89 44 24 08          	mov    %eax,0x8(%esp)
  102bee:	8b 45 0c             	mov    0xc(%ebp),%eax
  102bf1:	89 44 24 04          	mov    %eax,0x4(%esp)
  102bf5:	8b 45 08             	mov    0x8(%ebp),%eax
  102bf8:	89 04 24             	mov    %eax,(%esp)
  102bfb:	e8 02 00 00 00       	call   102c02 <vprintfmt>
    va_end(ap);
}
  102c00:	c9                   	leave  
  102c01:	c3                   	ret    

00102c02 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102c02:	55                   	push   %ebp
  102c03:	89 e5                	mov    %esp,%ebp
  102c05:	56                   	push   %esi
  102c06:	53                   	push   %ebx
  102c07:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102c0a:	eb 18                	jmp    102c24 <vprintfmt+0x22>
            if (ch == '\0') {
  102c0c:	85 db                	test   %ebx,%ebx
  102c0e:	75 05                	jne    102c15 <vprintfmt+0x13>
                return;
  102c10:	e9 d1 03 00 00       	jmp    102fe6 <vprintfmt+0x3e4>
            }
            putch(ch, putdat);
  102c15:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c18:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c1c:	89 1c 24             	mov    %ebx,(%esp)
  102c1f:	8b 45 08             	mov    0x8(%ebp),%eax
  102c22:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102c24:	8b 45 10             	mov    0x10(%ebp),%eax
  102c27:	8d 50 01             	lea    0x1(%eax),%edx
  102c2a:	89 55 10             	mov    %edx,0x10(%ebp)
  102c2d:	0f b6 00             	movzbl (%eax),%eax
  102c30:	0f b6 d8             	movzbl %al,%ebx
  102c33:	83 fb 25             	cmp    $0x25,%ebx
  102c36:	75 d4                	jne    102c0c <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  102c38:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102c3c:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102c43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102c46:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102c49:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102c50:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102c53:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102c56:	8b 45 10             	mov    0x10(%ebp),%eax
  102c59:	8d 50 01             	lea    0x1(%eax),%edx
  102c5c:	89 55 10             	mov    %edx,0x10(%ebp)
  102c5f:	0f b6 00             	movzbl (%eax),%eax
  102c62:	0f b6 d8             	movzbl %al,%ebx
  102c65:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102c68:	83 f8 55             	cmp    $0x55,%eax
  102c6b:	0f 87 44 03 00 00    	ja     102fb5 <vprintfmt+0x3b3>
  102c71:	8b 04 85 34 3d 10 00 	mov    0x103d34(,%eax,4),%eax
  102c78:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102c7a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102c7e:	eb d6                	jmp    102c56 <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102c80:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102c84:	eb d0                	jmp    102c56 <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102c86:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102c8d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102c90:	89 d0                	mov    %edx,%eax
  102c92:	c1 e0 02             	shl    $0x2,%eax
  102c95:	01 d0                	add    %edx,%eax
  102c97:	01 c0                	add    %eax,%eax
  102c99:	01 d8                	add    %ebx,%eax
  102c9b:	83 e8 30             	sub    $0x30,%eax
  102c9e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102ca1:	8b 45 10             	mov    0x10(%ebp),%eax
  102ca4:	0f b6 00             	movzbl (%eax),%eax
  102ca7:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102caa:	83 fb 2f             	cmp    $0x2f,%ebx
  102cad:	7e 0b                	jle    102cba <vprintfmt+0xb8>
  102caf:	83 fb 39             	cmp    $0x39,%ebx
  102cb2:	7f 06                	jg     102cba <vprintfmt+0xb8>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102cb4:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  102cb8:	eb d3                	jmp    102c8d <vprintfmt+0x8b>
            goto process_precision;
  102cba:	eb 33                	jmp    102cef <vprintfmt+0xed>

        case '*':
            precision = va_arg(ap, int);
  102cbc:	8b 45 14             	mov    0x14(%ebp),%eax
  102cbf:	8d 50 04             	lea    0x4(%eax),%edx
  102cc2:	89 55 14             	mov    %edx,0x14(%ebp)
  102cc5:	8b 00                	mov    (%eax),%eax
  102cc7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102cca:	eb 23                	jmp    102cef <vprintfmt+0xed>

        case '.':
            if (width < 0)
  102ccc:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102cd0:	79 0c                	jns    102cde <vprintfmt+0xdc>
                width = 0;
  102cd2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102cd9:	e9 78 ff ff ff       	jmp    102c56 <vprintfmt+0x54>
  102cde:	e9 73 ff ff ff       	jmp    102c56 <vprintfmt+0x54>

        case '#':
            altflag = 1;
  102ce3:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102cea:	e9 67 ff ff ff       	jmp    102c56 <vprintfmt+0x54>

        process_precision:
            if (width < 0)
  102cef:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102cf3:	79 12                	jns    102d07 <vprintfmt+0x105>
                width = precision, precision = -1;
  102cf5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102cf8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102cfb:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102d02:	e9 4f ff ff ff       	jmp    102c56 <vprintfmt+0x54>
  102d07:	e9 4a ff ff ff       	jmp    102c56 <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102d0c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  102d10:	e9 41 ff ff ff       	jmp    102c56 <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102d15:	8b 45 14             	mov    0x14(%ebp),%eax
  102d18:	8d 50 04             	lea    0x4(%eax),%edx
  102d1b:	89 55 14             	mov    %edx,0x14(%ebp)
  102d1e:	8b 00                	mov    (%eax),%eax
  102d20:	8b 55 0c             	mov    0xc(%ebp),%edx
  102d23:	89 54 24 04          	mov    %edx,0x4(%esp)
  102d27:	89 04 24             	mov    %eax,(%esp)
  102d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  102d2d:	ff d0                	call   *%eax
            break;
  102d2f:	e9 ac 02 00 00       	jmp    102fe0 <vprintfmt+0x3de>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102d34:	8b 45 14             	mov    0x14(%ebp),%eax
  102d37:	8d 50 04             	lea    0x4(%eax),%edx
  102d3a:	89 55 14             	mov    %edx,0x14(%ebp)
  102d3d:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102d3f:	85 db                	test   %ebx,%ebx
  102d41:	79 02                	jns    102d45 <vprintfmt+0x143>
                err = -err;
  102d43:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102d45:	83 fb 06             	cmp    $0x6,%ebx
  102d48:	7f 0b                	jg     102d55 <vprintfmt+0x153>
  102d4a:	8b 34 9d f4 3c 10 00 	mov    0x103cf4(,%ebx,4),%esi
  102d51:	85 f6                	test   %esi,%esi
  102d53:	75 23                	jne    102d78 <vprintfmt+0x176>
                printfmt(putch, putdat, "error %d", err);
  102d55:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102d59:	c7 44 24 08 21 3d 10 	movl   $0x103d21,0x8(%esp)
  102d60:	00 
  102d61:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d64:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d68:	8b 45 08             	mov    0x8(%ebp),%eax
  102d6b:	89 04 24             	mov    %eax,(%esp)
  102d6e:	e8 61 fe ff ff       	call   102bd4 <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102d73:	e9 68 02 00 00       	jmp    102fe0 <vprintfmt+0x3de>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  102d78:	89 74 24 0c          	mov    %esi,0xc(%esp)
  102d7c:	c7 44 24 08 2a 3d 10 	movl   $0x103d2a,0x8(%esp)
  102d83:	00 
  102d84:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d87:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  102d8e:	89 04 24             	mov    %eax,(%esp)
  102d91:	e8 3e fe ff ff       	call   102bd4 <printfmt>
            }
            break;
  102d96:	e9 45 02 00 00       	jmp    102fe0 <vprintfmt+0x3de>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102d9b:	8b 45 14             	mov    0x14(%ebp),%eax
  102d9e:	8d 50 04             	lea    0x4(%eax),%edx
  102da1:	89 55 14             	mov    %edx,0x14(%ebp)
  102da4:	8b 30                	mov    (%eax),%esi
  102da6:	85 f6                	test   %esi,%esi
  102da8:	75 05                	jne    102daf <vprintfmt+0x1ad>
                p = "(null)";
  102daa:	be 2d 3d 10 00       	mov    $0x103d2d,%esi
            }
            if (width > 0 && padc != '-') {
  102daf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102db3:	7e 3e                	jle    102df3 <vprintfmt+0x1f1>
  102db5:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102db9:	74 38                	je     102df3 <vprintfmt+0x1f1>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102dbb:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  102dbe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102dc1:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dc5:	89 34 24             	mov    %esi,(%esp)
  102dc8:	e8 15 03 00 00       	call   1030e2 <strnlen>
  102dcd:	29 c3                	sub    %eax,%ebx
  102dcf:	89 d8                	mov    %ebx,%eax
  102dd1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102dd4:	eb 17                	jmp    102ded <vprintfmt+0x1eb>
                    putch(padc, putdat);
  102dd6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102dda:	8b 55 0c             	mov    0xc(%ebp),%edx
  102ddd:	89 54 24 04          	mov    %edx,0x4(%esp)
  102de1:	89 04 24             	mov    %eax,(%esp)
  102de4:	8b 45 08             	mov    0x8(%ebp),%eax
  102de7:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  102de9:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102ded:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102df1:	7f e3                	jg     102dd6 <vprintfmt+0x1d4>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102df3:	eb 38                	jmp    102e2d <vprintfmt+0x22b>
                if (altflag && (ch < ' ' || ch > '~')) {
  102df5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102df9:	74 1f                	je     102e1a <vprintfmt+0x218>
  102dfb:	83 fb 1f             	cmp    $0x1f,%ebx
  102dfe:	7e 05                	jle    102e05 <vprintfmt+0x203>
  102e00:	83 fb 7e             	cmp    $0x7e,%ebx
  102e03:	7e 15                	jle    102e1a <vprintfmt+0x218>
                    putch('?', putdat);
  102e05:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e08:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e0c:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  102e13:	8b 45 08             	mov    0x8(%ebp),%eax
  102e16:	ff d0                	call   *%eax
  102e18:	eb 0f                	jmp    102e29 <vprintfmt+0x227>
                }
                else {
                    putch(ch, putdat);
  102e1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e1d:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e21:	89 1c 24             	mov    %ebx,(%esp)
  102e24:	8b 45 08             	mov    0x8(%ebp),%eax
  102e27:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102e29:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102e2d:	89 f0                	mov    %esi,%eax
  102e2f:	8d 70 01             	lea    0x1(%eax),%esi
  102e32:	0f b6 00             	movzbl (%eax),%eax
  102e35:	0f be d8             	movsbl %al,%ebx
  102e38:	85 db                	test   %ebx,%ebx
  102e3a:	74 10                	je     102e4c <vprintfmt+0x24a>
  102e3c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102e40:	78 b3                	js     102df5 <vprintfmt+0x1f3>
  102e42:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102e46:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102e4a:	79 a9                	jns    102df5 <vprintfmt+0x1f3>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102e4c:	eb 17                	jmp    102e65 <vprintfmt+0x263>
                putch(' ', putdat);
  102e4e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e51:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e55:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  102e5c:	8b 45 08             	mov    0x8(%ebp),%eax
  102e5f:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102e61:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102e65:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e69:	7f e3                	jg     102e4e <vprintfmt+0x24c>
                putch(' ', putdat);
            }
            break;
  102e6b:	e9 70 01 00 00       	jmp    102fe0 <vprintfmt+0x3de>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102e70:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102e73:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e77:	8d 45 14             	lea    0x14(%ebp),%eax
  102e7a:	89 04 24             	mov    %eax,(%esp)
  102e7d:	e8 0b fd ff ff       	call   102b8d <getint>
  102e82:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e85:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102e88:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e8b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102e8e:	85 d2                	test   %edx,%edx
  102e90:	79 26                	jns    102eb8 <vprintfmt+0x2b6>
                putch('-', putdat);
  102e92:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e95:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e99:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  102ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  102ea3:	ff d0                	call   *%eax
                num = -(long long)num;
  102ea5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ea8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102eab:	f7 d8                	neg    %eax
  102ead:	83 d2 00             	adc    $0x0,%edx
  102eb0:	f7 da                	neg    %edx
  102eb2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102eb5:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102eb8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102ebf:	e9 a8 00 00 00       	jmp    102f6c <vprintfmt+0x36a>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102ec4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ec7:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ecb:	8d 45 14             	lea    0x14(%ebp),%eax
  102ece:	89 04 24             	mov    %eax,(%esp)
  102ed1:	e8 68 fc ff ff       	call   102b3e <getuint>
  102ed6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ed9:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  102edc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102ee3:	e9 84 00 00 00       	jmp    102f6c <vprintfmt+0x36a>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  102ee8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102eeb:	89 44 24 04          	mov    %eax,0x4(%esp)
  102eef:	8d 45 14             	lea    0x14(%ebp),%eax
  102ef2:	89 04 24             	mov    %eax,(%esp)
  102ef5:	e8 44 fc ff ff       	call   102b3e <getuint>
  102efa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102efd:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  102f00:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  102f07:	eb 63                	jmp    102f6c <vprintfmt+0x36a>

        // pointer
        case 'p':
            putch('0', putdat);
  102f09:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f0c:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f10:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  102f17:	8b 45 08             	mov    0x8(%ebp),%eax
  102f1a:	ff d0                	call   *%eax
            putch('x', putdat);
  102f1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f1f:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f23:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  102f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  102f2d:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  102f2f:	8b 45 14             	mov    0x14(%ebp),%eax
  102f32:	8d 50 04             	lea    0x4(%eax),%edx
  102f35:	89 55 14             	mov    %edx,0x14(%ebp)
  102f38:	8b 00                	mov    (%eax),%eax
  102f3a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f3d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  102f44:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  102f4b:	eb 1f                	jmp    102f6c <vprintfmt+0x36a>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  102f4d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f50:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f54:	8d 45 14             	lea    0x14(%ebp),%eax
  102f57:	89 04 24             	mov    %eax,(%esp)
  102f5a:	e8 df fb ff ff       	call   102b3e <getuint>
  102f5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f62:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  102f65:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  102f6c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  102f70:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f73:	89 54 24 18          	mov    %edx,0x18(%esp)
  102f77:	8b 55 e8             	mov    -0x18(%ebp),%edx
  102f7a:	89 54 24 14          	mov    %edx,0x14(%esp)
  102f7e:	89 44 24 10          	mov    %eax,0x10(%esp)
  102f82:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f85:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102f88:	89 44 24 08          	mov    %eax,0x8(%esp)
  102f8c:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102f90:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f93:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f97:	8b 45 08             	mov    0x8(%ebp),%eax
  102f9a:	89 04 24             	mov    %eax,(%esp)
  102f9d:	e8 97 fa ff ff       	call   102a39 <printnum>
            break;
  102fa2:	eb 3c                	jmp    102fe0 <vprintfmt+0x3de>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  102fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fa7:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fab:	89 1c 24             	mov    %ebx,(%esp)
  102fae:	8b 45 08             	mov    0x8(%ebp),%eax
  102fb1:	ff d0                	call   *%eax
            break;
  102fb3:	eb 2b                	jmp    102fe0 <vprintfmt+0x3de>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  102fb5:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fb8:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fbc:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  102fc3:	8b 45 08             	mov    0x8(%ebp),%eax
  102fc6:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  102fc8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102fcc:	eb 04                	jmp    102fd2 <vprintfmt+0x3d0>
  102fce:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102fd2:	8b 45 10             	mov    0x10(%ebp),%eax
  102fd5:	83 e8 01             	sub    $0x1,%eax
  102fd8:	0f b6 00             	movzbl (%eax),%eax
  102fdb:	3c 25                	cmp    $0x25,%al
  102fdd:	75 ef                	jne    102fce <vprintfmt+0x3cc>
                /* do nothing */;
            break;
  102fdf:	90                   	nop
        }
    }
  102fe0:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102fe1:	e9 3e fc ff ff       	jmp    102c24 <vprintfmt+0x22>
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  102fe6:	83 c4 40             	add    $0x40,%esp
  102fe9:	5b                   	pop    %ebx
  102fea:	5e                   	pop    %esi
  102feb:	5d                   	pop    %ebp
  102fec:	c3                   	ret    

00102fed <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  102fed:	55                   	push   %ebp
  102fee:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  102ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ff3:	8b 40 08             	mov    0x8(%eax),%eax
  102ff6:	8d 50 01             	lea    0x1(%eax),%edx
  102ff9:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ffc:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  102fff:	8b 45 0c             	mov    0xc(%ebp),%eax
  103002:	8b 10                	mov    (%eax),%edx
  103004:	8b 45 0c             	mov    0xc(%ebp),%eax
  103007:	8b 40 04             	mov    0x4(%eax),%eax
  10300a:	39 c2                	cmp    %eax,%edx
  10300c:	73 12                	jae    103020 <sprintputch+0x33>
        *b->buf ++ = ch;
  10300e:	8b 45 0c             	mov    0xc(%ebp),%eax
  103011:	8b 00                	mov    (%eax),%eax
  103013:	8d 48 01             	lea    0x1(%eax),%ecx
  103016:	8b 55 0c             	mov    0xc(%ebp),%edx
  103019:	89 0a                	mov    %ecx,(%edx)
  10301b:	8b 55 08             	mov    0x8(%ebp),%edx
  10301e:	88 10                	mov    %dl,(%eax)
    }
}
  103020:	5d                   	pop    %ebp
  103021:	c3                   	ret    

00103022 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103022:	55                   	push   %ebp
  103023:	89 e5                	mov    %esp,%ebp
  103025:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103028:	8d 45 14             	lea    0x14(%ebp),%eax
  10302b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  10302e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103031:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103035:	8b 45 10             	mov    0x10(%ebp),%eax
  103038:	89 44 24 08          	mov    %eax,0x8(%esp)
  10303c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10303f:	89 44 24 04          	mov    %eax,0x4(%esp)
  103043:	8b 45 08             	mov    0x8(%ebp),%eax
  103046:	89 04 24             	mov    %eax,(%esp)
  103049:	e8 08 00 00 00       	call   103056 <vsnprintf>
  10304e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103051:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103054:	c9                   	leave  
  103055:	c3                   	ret    

00103056 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103056:	55                   	push   %ebp
  103057:	89 e5                	mov    %esp,%ebp
  103059:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  10305c:	8b 45 08             	mov    0x8(%ebp),%eax
  10305f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103062:	8b 45 0c             	mov    0xc(%ebp),%eax
  103065:	8d 50 ff             	lea    -0x1(%eax),%edx
  103068:	8b 45 08             	mov    0x8(%ebp),%eax
  10306b:	01 d0                	add    %edx,%eax
  10306d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103070:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  103077:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10307b:	74 0a                	je     103087 <vsnprintf+0x31>
  10307d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103080:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103083:	39 c2                	cmp    %eax,%edx
  103085:	76 07                	jbe    10308e <vsnprintf+0x38>
        return -E_INVAL;
  103087:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  10308c:	eb 2a                	jmp    1030b8 <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  10308e:	8b 45 14             	mov    0x14(%ebp),%eax
  103091:	89 44 24 0c          	mov    %eax,0xc(%esp)
  103095:	8b 45 10             	mov    0x10(%ebp),%eax
  103098:	89 44 24 08          	mov    %eax,0x8(%esp)
  10309c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  10309f:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030a3:	c7 04 24 ed 2f 10 00 	movl   $0x102fed,(%esp)
  1030aa:	e8 53 fb ff ff       	call   102c02 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  1030af:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1030b2:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1030b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1030b8:	c9                   	leave  
  1030b9:	c3                   	ret    

001030ba <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  1030ba:	55                   	push   %ebp
  1030bb:	89 e5                	mov    %esp,%ebp
  1030bd:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1030c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  1030c7:	eb 04                	jmp    1030cd <strlen+0x13>
        cnt ++;
  1030c9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  1030cd:	8b 45 08             	mov    0x8(%ebp),%eax
  1030d0:	8d 50 01             	lea    0x1(%eax),%edx
  1030d3:	89 55 08             	mov    %edx,0x8(%ebp)
  1030d6:	0f b6 00             	movzbl (%eax),%eax
  1030d9:	84 c0                	test   %al,%al
  1030db:	75 ec                	jne    1030c9 <strlen+0xf>
        cnt ++;
    }
    return cnt;
  1030dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1030e0:	c9                   	leave  
  1030e1:	c3                   	ret    

001030e2 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  1030e2:	55                   	push   %ebp
  1030e3:	89 e5                	mov    %esp,%ebp
  1030e5:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1030e8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  1030ef:	eb 04                	jmp    1030f5 <strnlen+0x13>
        cnt ++;
  1030f1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  1030f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1030f8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  1030fb:	73 10                	jae    10310d <strnlen+0x2b>
  1030fd:	8b 45 08             	mov    0x8(%ebp),%eax
  103100:	8d 50 01             	lea    0x1(%eax),%edx
  103103:	89 55 08             	mov    %edx,0x8(%ebp)
  103106:	0f b6 00             	movzbl (%eax),%eax
  103109:	84 c0                	test   %al,%al
  10310b:	75 e4                	jne    1030f1 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  10310d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  103110:	c9                   	leave  
  103111:	c3                   	ret    

00103112 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  103112:	55                   	push   %ebp
  103113:	89 e5                	mov    %esp,%ebp
  103115:	57                   	push   %edi
  103116:	56                   	push   %esi
  103117:	83 ec 20             	sub    $0x20,%esp
  10311a:	8b 45 08             	mov    0x8(%ebp),%eax
  10311d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103120:	8b 45 0c             	mov    0xc(%ebp),%eax
  103123:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  103126:	8b 55 f0             	mov    -0x10(%ebp),%edx
  103129:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10312c:	89 d1                	mov    %edx,%ecx
  10312e:	89 c2                	mov    %eax,%edx
  103130:	89 ce                	mov    %ecx,%esi
  103132:	89 d7                	mov    %edx,%edi
  103134:	ac                   	lods   %ds:(%esi),%al
  103135:	aa                   	stos   %al,%es:(%edi)
  103136:	84 c0                	test   %al,%al
  103138:	75 fa                	jne    103134 <strcpy+0x22>
  10313a:	89 fa                	mov    %edi,%edx
  10313c:	89 f1                	mov    %esi,%ecx
  10313e:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  103141:	89 55 e8             	mov    %edx,-0x18(%ebp)
  103144:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  103147:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  10314a:	83 c4 20             	add    $0x20,%esp
  10314d:	5e                   	pop    %esi
  10314e:	5f                   	pop    %edi
  10314f:	5d                   	pop    %ebp
  103150:	c3                   	ret    

00103151 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  103151:	55                   	push   %ebp
  103152:	89 e5                	mov    %esp,%ebp
  103154:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  103157:	8b 45 08             	mov    0x8(%ebp),%eax
  10315a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  10315d:	eb 21                	jmp    103180 <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  10315f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103162:	0f b6 10             	movzbl (%eax),%edx
  103165:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103168:	88 10                	mov    %dl,(%eax)
  10316a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10316d:	0f b6 00             	movzbl (%eax),%eax
  103170:	84 c0                	test   %al,%al
  103172:	74 04                	je     103178 <strncpy+0x27>
            src ++;
  103174:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  103178:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10317c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  103180:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103184:	75 d9                	jne    10315f <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  103186:	8b 45 08             	mov    0x8(%ebp),%eax
}
  103189:	c9                   	leave  
  10318a:	c3                   	ret    

0010318b <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  10318b:	55                   	push   %ebp
  10318c:	89 e5                	mov    %esp,%ebp
  10318e:	57                   	push   %edi
  10318f:	56                   	push   %esi
  103190:	83 ec 20             	sub    $0x20,%esp
  103193:	8b 45 08             	mov    0x8(%ebp),%eax
  103196:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103199:	8b 45 0c             	mov    0xc(%ebp),%eax
  10319c:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  10319f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1031a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031a5:	89 d1                	mov    %edx,%ecx
  1031a7:	89 c2                	mov    %eax,%edx
  1031a9:	89 ce                	mov    %ecx,%esi
  1031ab:	89 d7                	mov    %edx,%edi
  1031ad:	ac                   	lods   %ds:(%esi),%al
  1031ae:	ae                   	scas   %es:(%edi),%al
  1031af:	75 08                	jne    1031b9 <strcmp+0x2e>
  1031b1:	84 c0                	test   %al,%al
  1031b3:	75 f8                	jne    1031ad <strcmp+0x22>
  1031b5:	31 c0                	xor    %eax,%eax
  1031b7:	eb 04                	jmp    1031bd <strcmp+0x32>
  1031b9:	19 c0                	sbb    %eax,%eax
  1031bb:	0c 01                	or     $0x1,%al
  1031bd:	89 fa                	mov    %edi,%edx
  1031bf:	89 f1                	mov    %esi,%ecx
  1031c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1031c4:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  1031c7:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            "orb $1, %%al;"
            "3:"
            : "=a" (ret), "=&S" (d0), "=&D" (d1)
            : "1" (s1), "2" (s2)
            : "memory");
    return ret;
  1031ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  1031cd:	83 c4 20             	add    $0x20,%esp
  1031d0:	5e                   	pop    %esi
  1031d1:	5f                   	pop    %edi
  1031d2:	5d                   	pop    %ebp
  1031d3:	c3                   	ret    

001031d4 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  1031d4:	55                   	push   %ebp
  1031d5:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  1031d7:	eb 0c                	jmp    1031e5 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  1031d9:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1031dd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1031e1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  1031e5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1031e9:	74 1a                	je     103205 <strncmp+0x31>
  1031eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1031ee:	0f b6 00             	movzbl (%eax),%eax
  1031f1:	84 c0                	test   %al,%al
  1031f3:	74 10                	je     103205 <strncmp+0x31>
  1031f5:	8b 45 08             	mov    0x8(%ebp),%eax
  1031f8:	0f b6 10             	movzbl (%eax),%edx
  1031fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031fe:	0f b6 00             	movzbl (%eax),%eax
  103201:	38 c2                	cmp    %al,%dl
  103203:	74 d4                	je     1031d9 <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  103205:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103209:	74 18                	je     103223 <strncmp+0x4f>
  10320b:	8b 45 08             	mov    0x8(%ebp),%eax
  10320e:	0f b6 00             	movzbl (%eax),%eax
  103211:	0f b6 d0             	movzbl %al,%edx
  103214:	8b 45 0c             	mov    0xc(%ebp),%eax
  103217:	0f b6 00             	movzbl (%eax),%eax
  10321a:	0f b6 c0             	movzbl %al,%eax
  10321d:	29 c2                	sub    %eax,%edx
  10321f:	89 d0                	mov    %edx,%eax
  103221:	eb 05                	jmp    103228 <strncmp+0x54>
  103223:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103228:	5d                   	pop    %ebp
  103229:	c3                   	ret    

0010322a <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  10322a:	55                   	push   %ebp
  10322b:	89 e5                	mov    %esp,%ebp
  10322d:	83 ec 04             	sub    $0x4,%esp
  103230:	8b 45 0c             	mov    0xc(%ebp),%eax
  103233:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  103236:	eb 14                	jmp    10324c <strchr+0x22>
        if (*s == c) {
  103238:	8b 45 08             	mov    0x8(%ebp),%eax
  10323b:	0f b6 00             	movzbl (%eax),%eax
  10323e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  103241:	75 05                	jne    103248 <strchr+0x1e>
            return (char *)s;
  103243:	8b 45 08             	mov    0x8(%ebp),%eax
  103246:	eb 13                	jmp    10325b <strchr+0x31>
        }
        s ++;
  103248:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  10324c:	8b 45 08             	mov    0x8(%ebp),%eax
  10324f:	0f b6 00             	movzbl (%eax),%eax
  103252:	84 c0                	test   %al,%al
  103254:	75 e2                	jne    103238 <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  103256:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10325b:	c9                   	leave  
  10325c:	c3                   	ret    

0010325d <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  10325d:	55                   	push   %ebp
  10325e:	89 e5                	mov    %esp,%ebp
  103260:	83 ec 04             	sub    $0x4,%esp
  103263:	8b 45 0c             	mov    0xc(%ebp),%eax
  103266:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  103269:	eb 11                	jmp    10327c <strfind+0x1f>
        if (*s == c) {
  10326b:	8b 45 08             	mov    0x8(%ebp),%eax
  10326e:	0f b6 00             	movzbl (%eax),%eax
  103271:	3a 45 fc             	cmp    -0x4(%ebp),%al
  103274:	75 02                	jne    103278 <strfind+0x1b>
            break;
  103276:	eb 0e                	jmp    103286 <strfind+0x29>
        }
        s ++;
  103278:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  10327c:	8b 45 08             	mov    0x8(%ebp),%eax
  10327f:	0f b6 00             	movzbl (%eax),%eax
  103282:	84 c0                	test   %al,%al
  103284:	75 e5                	jne    10326b <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  103286:	8b 45 08             	mov    0x8(%ebp),%eax
}
  103289:	c9                   	leave  
  10328a:	c3                   	ret    

0010328b <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  10328b:	55                   	push   %ebp
  10328c:	89 e5                	mov    %esp,%ebp
  10328e:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  103291:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  103298:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  10329f:	eb 04                	jmp    1032a5 <strtol+0x1a>
        s ++;
  1032a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1032a5:	8b 45 08             	mov    0x8(%ebp),%eax
  1032a8:	0f b6 00             	movzbl (%eax),%eax
  1032ab:	3c 20                	cmp    $0x20,%al
  1032ad:	74 f2                	je     1032a1 <strtol+0x16>
  1032af:	8b 45 08             	mov    0x8(%ebp),%eax
  1032b2:	0f b6 00             	movzbl (%eax),%eax
  1032b5:	3c 09                	cmp    $0x9,%al
  1032b7:	74 e8                	je     1032a1 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  1032b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1032bc:	0f b6 00             	movzbl (%eax),%eax
  1032bf:	3c 2b                	cmp    $0x2b,%al
  1032c1:	75 06                	jne    1032c9 <strtol+0x3e>
        s ++;
  1032c3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1032c7:	eb 15                	jmp    1032de <strtol+0x53>
    }
    else if (*s == '-') {
  1032c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1032cc:	0f b6 00             	movzbl (%eax),%eax
  1032cf:	3c 2d                	cmp    $0x2d,%al
  1032d1:	75 0b                	jne    1032de <strtol+0x53>
        s ++, neg = 1;
  1032d3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1032d7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  1032de:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1032e2:	74 06                	je     1032ea <strtol+0x5f>
  1032e4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  1032e8:	75 24                	jne    10330e <strtol+0x83>
  1032ea:	8b 45 08             	mov    0x8(%ebp),%eax
  1032ed:	0f b6 00             	movzbl (%eax),%eax
  1032f0:	3c 30                	cmp    $0x30,%al
  1032f2:	75 1a                	jne    10330e <strtol+0x83>
  1032f4:	8b 45 08             	mov    0x8(%ebp),%eax
  1032f7:	83 c0 01             	add    $0x1,%eax
  1032fa:	0f b6 00             	movzbl (%eax),%eax
  1032fd:	3c 78                	cmp    $0x78,%al
  1032ff:	75 0d                	jne    10330e <strtol+0x83>
        s += 2, base = 16;
  103301:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  103305:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  10330c:	eb 2a                	jmp    103338 <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  10330e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103312:	75 17                	jne    10332b <strtol+0xa0>
  103314:	8b 45 08             	mov    0x8(%ebp),%eax
  103317:	0f b6 00             	movzbl (%eax),%eax
  10331a:	3c 30                	cmp    $0x30,%al
  10331c:	75 0d                	jne    10332b <strtol+0xa0>
        s ++, base = 8;
  10331e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103322:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  103329:	eb 0d                	jmp    103338 <strtol+0xad>
    }
    else if (base == 0) {
  10332b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10332f:	75 07                	jne    103338 <strtol+0xad>
        base = 10;
  103331:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  103338:	8b 45 08             	mov    0x8(%ebp),%eax
  10333b:	0f b6 00             	movzbl (%eax),%eax
  10333e:	3c 2f                	cmp    $0x2f,%al
  103340:	7e 1b                	jle    10335d <strtol+0xd2>
  103342:	8b 45 08             	mov    0x8(%ebp),%eax
  103345:	0f b6 00             	movzbl (%eax),%eax
  103348:	3c 39                	cmp    $0x39,%al
  10334a:	7f 11                	jg     10335d <strtol+0xd2>
            dig = *s - '0';
  10334c:	8b 45 08             	mov    0x8(%ebp),%eax
  10334f:	0f b6 00             	movzbl (%eax),%eax
  103352:	0f be c0             	movsbl %al,%eax
  103355:	83 e8 30             	sub    $0x30,%eax
  103358:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10335b:	eb 48                	jmp    1033a5 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  10335d:	8b 45 08             	mov    0x8(%ebp),%eax
  103360:	0f b6 00             	movzbl (%eax),%eax
  103363:	3c 60                	cmp    $0x60,%al
  103365:	7e 1b                	jle    103382 <strtol+0xf7>
  103367:	8b 45 08             	mov    0x8(%ebp),%eax
  10336a:	0f b6 00             	movzbl (%eax),%eax
  10336d:	3c 7a                	cmp    $0x7a,%al
  10336f:	7f 11                	jg     103382 <strtol+0xf7>
            dig = *s - 'a' + 10;
  103371:	8b 45 08             	mov    0x8(%ebp),%eax
  103374:	0f b6 00             	movzbl (%eax),%eax
  103377:	0f be c0             	movsbl %al,%eax
  10337a:	83 e8 57             	sub    $0x57,%eax
  10337d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103380:	eb 23                	jmp    1033a5 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  103382:	8b 45 08             	mov    0x8(%ebp),%eax
  103385:	0f b6 00             	movzbl (%eax),%eax
  103388:	3c 40                	cmp    $0x40,%al
  10338a:	7e 3d                	jle    1033c9 <strtol+0x13e>
  10338c:	8b 45 08             	mov    0x8(%ebp),%eax
  10338f:	0f b6 00             	movzbl (%eax),%eax
  103392:	3c 5a                	cmp    $0x5a,%al
  103394:	7f 33                	jg     1033c9 <strtol+0x13e>
            dig = *s - 'A' + 10;
  103396:	8b 45 08             	mov    0x8(%ebp),%eax
  103399:	0f b6 00             	movzbl (%eax),%eax
  10339c:	0f be c0             	movsbl %al,%eax
  10339f:	83 e8 37             	sub    $0x37,%eax
  1033a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1033a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1033a8:	3b 45 10             	cmp    0x10(%ebp),%eax
  1033ab:	7c 02                	jl     1033af <strtol+0x124>
            break;
  1033ad:	eb 1a                	jmp    1033c9 <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  1033af:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1033b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1033b6:	0f af 45 10          	imul   0x10(%ebp),%eax
  1033ba:	89 c2                	mov    %eax,%edx
  1033bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1033bf:	01 d0                	add    %edx,%eax
  1033c1:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  1033c4:	e9 6f ff ff ff       	jmp    103338 <strtol+0xad>

    if (endptr) {
  1033c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1033cd:	74 08                	je     1033d7 <strtol+0x14c>
        *endptr = (char *) s;
  1033cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033d2:	8b 55 08             	mov    0x8(%ebp),%edx
  1033d5:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  1033d7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  1033db:	74 07                	je     1033e4 <strtol+0x159>
  1033dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1033e0:	f7 d8                	neg    %eax
  1033e2:	eb 03                	jmp    1033e7 <strtol+0x15c>
  1033e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  1033e7:	c9                   	leave  
  1033e8:	c3                   	ret    

001033e9 <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  1033e9:	55                   	push   %ebp
  1033ea:	89 e5                	mov    %esp,%ebp
  1033ec:	57                   	push   %edi
  1033ed:	83 ec 24             	sub    $0x24,%esp
  1033f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033f3:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  1033f6:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  1033fa:	8b 55 08             	mov    0x8(%ebp),%edx
  1033fd:	89 55 f8             	mov    %edx,-0x8(%ebp)
  103400:	88 45 f7             	mov    %al,-0x9(%ebp)
  103403:	8b 45 10             	mov    0x10(%ebp),%eax
  103406:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  103409:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  10340c:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  103410:	8b 55 f8             	mov    -0x8(%ebp),%edx
  103413:	89 d7                	mov    %edx,%edi
  103415:	f3 aa                	rep stos %al,%es:(%edi)
  103417:	89 fa                	mov    %edi,%edx
  103419:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  10341c:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  10341f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  103422:	83 c4 24             	add    $0x24,%esp
  103425:	5f                   	pop    %edi
  103426:	5d                   	pop    %ebp
  103427:	c3                   	ret    

00103428 <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  103428:	55                   	push   %ebp
  103429:	89 e5                	mov    %esp,%ebp
  10342b:	57                   	push   %edi
  10342c:	56                   	push   %esi
  10342d:	53                   	push   %ebx
  10342e:	83 ec 30             	sub    $0x30,%esp
  103431:	8b 45 08             	mov    0x8(%ebp),%eax
  103434:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103437:	8b 45 0c             	mov    0xc(%ebp),%eax
  10343a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10343d:	8b 45 10             	mov    0x10(%ebp),%eax
  103440:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  103443:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103446:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  103449:	73 42                	jae    10348d <memmove+0x65>
  10344b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10344e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103451:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103454:	89 45 e0             	mov    %eax,-0x20(%ebp)
  103457:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10345a:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  10345d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103460:	c1 e8 02             	shr    $0x2,%eax
  103463:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  103465:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  103468:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10346b:	89 d7                	mov    %edx,%edi
  10346d:	89 c6                	mov    %eax,%esi
  10346f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103471:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  103474:	83 e1 03             	and    $0x3,%ecx
  103477:	74 02                	je     10347b <memmove+0x53>
  103479:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  10347b:	89 f0                	mov    %esi,%eax
  10347d:	89 fa                	mov    %edi,%edx
  10347f:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  103482:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  103485:	89 45 d0             	mov    %eax,-0x30(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  103488:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  10348b:	eb 36                	jmp    1034c3 <memmove+0x9b>
    asm volatile (
            "std;"
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  10348d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103490:	8d 50 ff             	lea    -0x1(%eax),%edx
  103493:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103496:	01 c2                	add    %eax,%edx
  103498:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10349b:	8d 48 ff             	lea    -0x1(%eax),%ecx
  10349e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034a1:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  1034a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034a7:	89 c1                	mov    %eax,%ecx
  1034a9:	89 d8                	mov    %ebx,%eax
  1034ab:	89 d6                	mov    %edx,%esi
  1034ad:	89 c7                	mov    %eax,%edi
  1034af:	fd                   	std    
  1034b0:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1034b2:	fc                   	cld    
  1034b3:	89 f8                	mov    %edi,%eax
  1034b5:	89 f2                	mov    %esi,%edx
  1034b7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  1034ba:	89 55 c8             	mov    %edx,-0x38(%ebp)
  1034bd:	89 45 c4             	mov    %eax,-0x3c(%ebp)
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
            : "memory");
    return dst;
  1034c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  1034c3:	83 c4 30             	add    $0x30,%esp
  1034c6:	5b                   	pop    %ebx
  1034c7:	5e                   	pop    %esi
  1034c8:	5f                   	pop    %edi
  1034c9:	5d                   	pop    %ebp
  1034ca:	c3                   	ret    

001034cb <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  1034cb:	55                   	push   %ebp
  1034cc:	89 e5                	mov    %esp,%ebp
  1034ce:	57                   	push   %edi
  1034cf:	56                   	push   %esi
  1034d0:	83 ec 20             	sub    $0x20,%esp
  1034d3:	8b 45 08             	mov    0x8(%ebp),%eax
  1034d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1034d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1034dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1034df:	8b 45 10             	mov    0x10(%ebp),%eax
  1034e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1034e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1034e8:	c1 e8 02             	shr    $0x2,%eax
  1034eb:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  1034ed:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1034f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034f3:	89 d7                	mov    %edx,%edi
  1034f5:	89 c6                	mov    %eax,%esi
  1034f7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1034f9:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  1034fc:	83 e1 03             	and    $0x3,%ecx
  1034ff:	74 02                	je     103503 <memcpy+0x38>
  103501:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103503:	89 f0                	mov    %esi,%eax
  103505:	89 fa                	mov    %edi,%edx
  103507:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  10350a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  10350d:	89 45 e0             	mov    %eax,-0x20(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  103510:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  103513:	83 c4 20             	add    $0x20,%esp
  103516:	5e                   	pop    %esi
  103517:	5f                   	pop    %edi
  103518:	5d                   	pop    %ebp
  103519:	c3                   	ret    

0010351a <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  10351a:	55                   	push   %ebp
  10351b:	89 e5                	mov    %esp,%ebp
  10351d:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  103520:	8b 45 08             	mov    0x8(%ebp),%eax
  103523:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  103526:	8b 45 0c             	mov    0xc(%ebp),%eax
  103529:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  10352c:	eb 30                	jmp    10355e <memcmp+0x44>
        if (*s1 != *s2) {
  10352e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103531:	0f b6 10             	movzbl (%eax),%edx
  103534:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103537:	0f b6 00             	movzbl (%eax),%eax
  10353a:	38 c2                	cmp    %al,%dl
  10353c:	74 18                	je     103556 <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  10353e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103541:	0f b6 00             	movzbl (%eax),%eax
  103544:	0f b6 d0             	movzbl %al,%edx
  103547:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10354a:	0f b6 00             	movzbl (%eax),%eax
  10354d:	0f b6 c0             	movzbl %al,%eax
  103550:	29 c2                	sub    %eax,%edx
  103552:	89 d0                	mov    %edx,%eax
  103554:	eb 1a                	jmp    103570 <memcmp+0x56>
        }
        s1 ++, s2 ++;
  103556:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10355a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  10355e:	8b 45 10             	mov    0x10(%ebp),%eax
  103561:	8d 50 ff             	lea    -0x1(%eax),%edx
  103564:	89 55 10             	mov    %edx,0x10(%ebp)
  103567:	85 c0                	test   %eax,%eax
  103569:	75 c3                	jne    10352e <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  10356b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103570:	c9                   	leave  
  103571:	c3                   	ret    
