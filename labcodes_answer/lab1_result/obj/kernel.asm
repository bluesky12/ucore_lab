
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
  100027:	e8 e3 33 00 00       	call   10340f <memset>

    cons_init();                // init the console
  10002c:	e8 44 15 00 00       	call   101575 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 a0 35 10 00 	movl   $0x1035a0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 bc 35 10 00 	movl   $0x1035bc,(%esp)
  100046:	e8 d7 02 00 00       	call   100322 <cprintf>

    print_kerninfo();
  10004b:	e8 06 08 00 00       	call   100856 <print_kerninfo>

    grade_backtrace();
  100050:	e8 8b 00 00 00       	call   1000e0 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 fb 29 00 00       	call   102a55 <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 59 16 00 00       	call   1016b8 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 d1 17 00 00       	call   101835 <idt_init>

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
  100130:	c7 04 24 c1 35 10 00 	movl   $0x1035c1,(%esp)
  100137:	e8 e6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  10013c:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100140:	0f b7 d0             	movzwl %ax,%edx
  100143:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100148:	89 54 24 08          	mov    %edx,0x8(%esp)
  10014c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100150:	c7 04 24 cf 35 10 00 	movl   $0x1035cf,(%esp)
  100157:	e8 c6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  10015c:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100160:	0f b7 d0             	movzwl %ax,%edx
  100163:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100168:	89 54 24 08          	mov    %edx,0x8(%esp)
  10016c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100170:	c7 04 24 dd 35 10 00 	movl   $0x1035dd,(%esp)
  100177:	e8 a6 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  10017c:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100180:	0f b7 d0             	movzwl %ax,%edx
  100183:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100188:	89 54 24 08          	mov    %edx,0x8(%esp)
  10018c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100190:	c7 04 24 eb 35 10 00 	movl   $0x1035eb,(%esp)
  100197:	e8 86 01 00 00       	call   100322 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  10019c:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1001a0:	0f b7 d0             	movzwl %ax,%edx
  1001a3:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001a8:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001b0:	c7 04 24 f9 35 10 00 	movl   $0x1035f9,(%esp)
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
  1001eb:	c7 04 24 08 36 10 00 	movl   $0x103608,(%esp)
  1001f2:	e8 2b 01 00 00       	call   100322 <cprintf>
    lab1_switch_to_user();
  1001f7:	e8 cf ff ff ff       	call   1001cb <lab1_switch_to_user>
    lab1_print_cur_status();
  1001fc:	e8 04 ff ff ff       	call   100105 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  100201:	c7 04 24 28 36 10 00 	movl   $0x103628,(%esp)
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
  10022c:	c7 04 24 47 36 10 00 	movl   $0x103647,(%esp)
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
  100318:	e8 0b 29 00 00       	call   102c28 <vprintfmt>
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
  100522:	c7 00 4c 36 10 00    	movl   $0x10364c,(%eax)
    info->eip_line = 0;
  100528:	8b 45 0c             	mov    0xc(%ebp),%eax
  10052b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100532:	8b 45 0c             	mov    0xc(%ebp),%eax
  100535:	c7 40 08 4c 36 10 00 	movl   $0x10364c,0x8(%eax)
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
  100559:	c7 45 f4 cc 3e 10 00 	movl   $0x103ecc,-0xc(%ebp)
    stab_end = __STAB_END__;
  100560:	c7 45 f0 e4 b6 10 00 	movl   $0x10b6e4,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100567:	c7 45 ec e5 b6 10 00 	movl   $0x10b6e5,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10056e:	c7 45 e8 f4 d6 10 00 	movl   $0x10d6f4,-0x18(%ebp)

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
  1006cd:	e8 b1 2b 00 00       	call   103283 <strfind>
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
  10085c:	c7 04 24 56 36 10 00 	movl   $0x103656,(%esp)
  100863:	e8 ba fa ff ff       	call   100322 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100868:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10086f:	00 
  100870:	c7 04 24 6f 36 10 00 	movl   $0x10366f,(%esp)
  100877:	e8 a6 fa ff ff       	call   100322 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  10087c:	c7 44 24 04 98 35 10 	movl   $0x103598,0x4(%esp)
  100883:	00 
  100884:	c7 04 24 87 36 10 00 	movl   $0x103687,(%esp)
  10088b:	e8 92 fa ff ff       	call   100322 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100890:	c7 44 24 04 16 ea 10 	movl   $0x10ea16,0x4(%esp)
  100897:	00 
  100898:	c7 04 24 9f 36 10 00 	movl   $0x10369f,(%esp)
  10089f:	e8 7e fa ff ff       	call   100322 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  1008a4:	c7 44 24 04 80 fd 10 	movl   $0x10fd80,0x4(%esp)
  1008ab:	00 
  1008ac:	c7 04 24 b7 36 10 00 	movl   $0x1036b7,(%esp)
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
  1008de:	c7 04 24 d0 36 10 00 	movl   $0x1036d0,(%esp)
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
  100912:	c7 04 24 fa 36 10 00 	movl   $0x1036fa,(%esp)
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
  100981:	c7 04 24 16 37 10 00 	movl   $0x103716,(%esp)
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
  1009d3:	c7 04 24 28 37 10 00 	movl   $0x103728,(%esp)
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
  100a06:	c7 04 24 44 37 10 00 	movl   $0x103744,(%esp)
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
  100a1c:	c7 04 24 4c 37 10 00 	movl   $0x10374c,(%esp)
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
  100a91:	c7 04 24 d0 37 10 00 	movl   $0x1037d0,(%esp)
  100a98:	e8 b3 27 00 00       	call   103250 <strchr>
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
  100abb:	c7 04 24 d5 37 10 00 	movl   $0x1037d5,(%esp)
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
  100afe:	c7 04 24 d0 37 10 00 	movl   $0x1037d0,(%esp)
  100b05:	e8 46 27 00 00       	call   103250 <strchr>
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
  100b6a:	e8 42 26 00 00       	call   1031b1 <strcmp>
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
  100bb8:	c7 04 24 f3 37 10 00 	movl   $0x1037f3,(%esp)
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
  100bd1:	c7 04 24 0c 38 10 00 	movl   $0x10380c,(%esp)
  100bd8:	e8 45 f7 ff ff       	call   100322 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100bdd:	c7 04 24 34 38 10 00 	movl   $0x103834,(%esp)
  100be4:	e8 39 f7 ff ff       	call   100322 <cprintf>

    if (tf != NULL) {
  100be9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100bed:	74 0b                	je     100bfa <kmonitor+0x2f>
        print_trapframe(tf);
  100bef:	8b 45 08             	mov    0x8(%ebp),%eax
  100bf2:	89 04 24             	mov    %eax,(%esp)
  100bf5:	e8 f3 0d 00 00       	call   1019ed <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100bfa:	c7 04 24 59 38 10 00 	movl   $0x103859,(%esp)
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
  100c69:	c7 04 24 5d 38 10 00 	movl   $0x10385d,(%esp)
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
  100cdb:	c7 04 24 66 38 10 00 	movl   $0x103866,(%esp)
  100ce2:	e8 3b f6 ff ff       	call   100322 <cprintf>
    vcprintf(fmt, ap);
  100ce7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cea:	89 44 24 04          	mov    %eax,0x4(%esp)
  100cee:	8b 45 10             	mov    0x10(%ebp),%eax
  100cf1:	89 04 24             	mov    %eax,(%esp)
  100cf4:	e8 f6 f5 ff ff       	call   1002ef <vcprintf>
    cprintf("\n");
  100cf9:	c7 04 24 82 38 10 00 	movl   $0x103882,(%esp)
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
  100d32:	c7 04 24 84 38 10 00 	movl   $0x103884,(%esp)
  100d39:	e8 e4 f5 ff ff       	call   100322 <cprintf>
    vcprintf(fmt, ap);
  100d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d41:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d45:	8b 45 10             	mov    0x10(%ebp),%eax
  100d48:	89 04 24             	mov    %eax,(%esp)
  100d4b:	e8 9f f5 ff ff       	call   1002ef <vcprintf>
    cprintf("\n");
  100d50:	c7 04 24 82 38 10 00 	movl   $0x103882,(%esp)
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
  100db1:	c7 04 24 a2 38 10 00 	movl   $0x1038a2,(%esp)
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
  10119e:	e8 ab 22 00 00       	call   10344e <memmove>
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
  101524:	c7 04 24 bd 38 10 00 	movl   $0x1038bd,(%esp)
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
  101593:	c7 04 24 c9 38 10 00 	movl   $0x1038c9,(%esp)
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
  101801:	c7 04 24 00 39 10 00 	movl   $0x103900,(%esp)
  101808:	e8 15 eb ff ff       	call   100322 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  10180d:	c7 04 24 0a 39 10 00 	movl   $0x10390a,(%esp)
  101814:	e8 09 eb ff ff       	call   100322 <cprintf>
    panic("EOT: kernel seems ok.");
  101819:	c7 44 24 08 18 39 10 	movl   $0x103918,0x8(%esp)
  101820:	00 
  101821:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  101828:	00 
  101829:	c7 04 24 2e 39 10 00 	movl   $0x10392e,(%esp)
  101830:	e8 77 f4 ff ff       	call   100cac <__panic>

00101835 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101835:	55                   	push   %ebp
  101836:	89 e5                	mov    %esp,%ebp
  101838:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  10183b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101842:	e9 c3 00 00 00       	jmp    10190a <idt_init+0xd5>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  101847:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10184a:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  101851:	89 c2                	mov    %eax,%edx
  101853:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101856:	66 89 14 c5 a0 f0 10 	mov    %dx,0x10f0a0(,%eax,8)
  10185d:	00 
  10185e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101861:	66 c7 04 c5 a2 f0 10 	movw   $0x8,0x10f0a2(,%eax,8)
  101868:	00 08 00 
  10186b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10186e:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  101875:	00 
  101876:	83 e2 e0             	and    $0xffffffe0,%edx
  101879:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  101880:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101883:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  10188a:	00 
  10188b:	83 e2 1f             	and    $0x1f,%edx
  10188e:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  101895:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101898:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  10189f:	00 
  1018a0:	83 e2 f0             	and    $0xfffffff0,%edx
  1018a3:	83 ca 0e             	or     $0xe,%edx
  1018a6:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018b0:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018b7:	00 
  1018b8:	83 e2 ef             	and    $0xffffffef,%edx
  1018bb:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018c5:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018cc:	00 
  1018cd:	83 e2 9f             	and    $0xffffff9f,%edx
  1018d0:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018da:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018e1:	00 
  1018e2:	83 ca 80             	or     $0xffffff80,%edx
  1018e5:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018ef:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  1018f6:	c1 e8 10             	shr    $0x10,%eax
  1018f9:	89 c2                	mov    %eax,%edx
  1018fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018fe:	66 89 14 c5 a6 f0 10 	mov    %dx,0x10f0a6(,%eax,8)
  101905:	00 
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < sizeof(idt) / sizeof(struct gatedesc); i ++) {
  101906:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10190a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10190d:	3d ff 00 00 00       	cmp    $0xff,%eax
  101912:	0f 86 2f ff ff ff    	jbe    101847 <idt_init+0x12>
        SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
    }
	// set for switch from user to kernel
    SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  101918:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  10191d:	66 a3 68 f4 10 00    	mov    %ax,0x10f468
  101923:	66 c7 05 6a f4 10 00 	movw   $0x8,0x10f46a
  10192a:	08 00 
  10192c:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101933:	83 e0 e0             	and    $0xffffffe0,%eax
  101936:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10193b:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101942:	83 e0 1f             	and    $0x1f,%eax
  101945:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10194a:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101951:	83 e0 f0             	and    $0xfffffff0,%eax
  101954:	83 c8 0e             	or     $0xe,%eax
  101957:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10195c:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101963:	83 e0 ef             	and    $0xffffffef,%eax
  101966:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10196b:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101972:	83 c8 60             	or     $0x60,%eax
  101975:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10197a:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101981:	83 c8 80             	or     $0xffffff80,%eax
  101984:	a2 6d f4 10 00       	mov    %al,0x10f46d
  101989:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  10198e:	c1 e8 10             	shr    $0x10,%eax
  101991:	66 a3 6e f4 10 00    	mov    %ax,0x10f46e
  101997:	c7 45 f8 60 e5 10 00 	movl   $0x10e560,-0x8(%ebp)
    return ebp;
}

static inline void
lidt(struct pseudodesc *pd) {
    asm volatile ("lidt (%0)" :: "r" (pd));
  10199e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1019a1:	0f 01 18             	lidtl  (%eax)
	// load the IDT
    lidt(&idt_pd);
}
  1019a4:	c9                   	leave  
  1019a5:	c3                   	ret    

001019a6 <trapname>:

static const char *
trapname(int trapno) {
  1019a6:	55                   	push   %ebp
  1019a7:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  1019a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1019ac:	83 f8 13             	cmp    $0x13,%eax
  1019af:	77 0c                	ja     1019bd <trapname+0x17>
        return excnames[trapno];
  1019b1:	8b 45 08             	mov    0x8(%ebp),%eax
  1019b4:	8b 04 85 80 3c 10 00 	mov    0x103c80(,%eax,4),%eax
  1019bb:	eb 18                	jmp    1019d5 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  1019bd:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  1019c1:	7e 0d                	jle    1019d0 <trapname+0x2a>
  1019c3:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  1019c7:	7f 07                	jg     1019d0 <trapname+0x2a>
        return "Hardware Interrupt";
  1019c9:	b8 3f 39 10 00       	mov    $0x10393f,%eax
  1019ce:	eb 05                	jmp    1019d5 <trapname+0x2f>
    }
    return "(unknown trap)";
  1019d0:	b8 52 39 10 00       	mov    $0x103952,%eax
}
  1019d5:	5d                   	pop    %ebp
  1019d6:	c3                   	ret    

001019d7 <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  1019d7:	55                   	push   %ebp
  1019d8:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  1019da:	8b 45 08             	mov    0x8(%ebp),%eax
  1019dd:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  1019e1:	66 83 f8 08          	cmp    $0x8,%ax
  1019e5:	0f 94 c0             	sete   %al
  1019e8:	0f b6 c0             	movzbl %al,%eax
}
  1019eb:	5d                   	pop    %ebp
  1019ec:	c3                   	ret    

001019ed <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  1019ed:	55                   	push   %ebp
  1019ee:	89 e5                	mov    %esp,%ebp
  1019f0:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  1019f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1019f6:	89 44 24 04          	mov    %eax,0x4(%esp)
  1019fa:	c7 04 24 93 39 10 00 	movl   $0x103993,(%esp)
  101a01:	e8 1c e9 ff ff       	call   100322 <cprintf>
    print_regs(&tf->tf_regs);
  101a06:	8b 45 08             	mov    0x8(%ebp),%eax
  101a09:	89 04 24             	mov    %eax,(%esp)
  101a0c:	e8 a1 01 00 00       	call   101bb2 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101a11:	8b 45 08             	mov    0x8(%ebp),%eax
  101a14:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101a18:	0f b7 c0             	movzwl %ax,%eax
  101a1b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a1f:	c7 04 24 a4 39 10 00 	movl   $0x1039a4,(%esp)
  101a26:	e8 f7 e8 ff ff       	call   100322 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  101a2e:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101a32:	0f b7 c0             	movzwl %ax,%eax
  101a35:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a39:	c7 04 24 b7 39 10 00 	movl   $0x1039b7,(%esp)
  101a40:	e8 dd e8 ff ff       	call   100322 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101a45:	8b 45 08             	mov    0x8(%ebp),%eax
  101a48:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101a4c:	0f b7 c0             	movzwl %ax,%eax
  101a4f:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a53:	c7 04 24 ca 39 10 00 	movl   $0x1039ca,(%esp)
  101a5a:	e8 c3 e8 ff ff       	call   100322 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  101a62:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101a66:	0f b7 c0             	movzwl %ax,%eax
  101a69:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a6d:	c7 04 24 dd 39 10 00 	movl   $0x1039dd,(%esp)
  101a74:	e8 a9 e8 ff ff       	call   100322 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101a79:	8b 45 08             	mov    0x8(%ebp),%eax
  101a7c:	8b 40 30             	mov    0x30(%eax),%eax
  101a7f:	89 04 24             	mov    %eax,(%esp)
  101a82:	e8 1f ff ff ff       	call   1019a6 <trapname>
  101a87:	8b 55 08             	mov    0x8(%ebp),%edx
  101a8a:	8b 52 30             	mov    0x30(%edx),%edx
  101a8d:	89 44 24 08          	mov    %eax,0x8(%esp)
  101a91:	89 54 24 04          	mov    %edx,0x4(%esp)
  101a95:	c7 04 24 f0 39 10 00 	movl   $0x1039f0,(%esp)
  101a9c:	e8 81 e8 ff ff       	call   100322 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101aa1:	8b 45 08             	mov    0x8(%ebp),%eax
  101aa4:	8b 40 34             	mov    0x34(%eax),%eax
  101aa7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aab:	c7 04 24 02 3a 10 00 	movl   $0x103a02,(%esp)
  101ab2:	e8 6b e8 ff ff       	call   100322 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  101aba:	8b 40 38             	mov    0x38(%eax),%eax
  101abd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ac1:	c7 04 24 11 3a 10 00 	movl   $0x103a11,(%esp)
  101ac8:	e8 55 e8 ff ff       	call   100322 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101acd:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101ad4:	0f b7 c0             	movzwl %ax,%eax
  101ad7:	89 44 24 04          	mov    %eax,0x4(%esp)
  101adb:	c7 04 24 20 3a 10 00 	movl   $0x103a20,(%esp)
  101ae2:	e8 3b e8 ff ff       	call   100322 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  101aea:	8b 40 40             	mov    0x40(%eax),%eax
  101aed:	89 44 24 04          	mov    %eax,0x4(%esp)
  101af1:	c7 04 24 33 3a 10 00 	movl   $0x103a33,(%esp)
  101af8:	e8 25 e8 ff ff       	call   100322 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101afd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101b04:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101b0b:	eb 3e                	jmp    101b4b <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101b0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101b10:	8b 50 40             	mov    0x40(%eax),%edx
  101b13:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101b16:	21 d0                	and    %edx,%eax
  101b18:	85 c0                	test   %eax,%eax
  101b1a:	74 28                	je     101b44 <print_trapframe+0x157>
  101b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b1f:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b26:	85 c0                	test   %eax,%eax
  101b28:	74 1a                	je     101b44 <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
  101b2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b2d:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b34:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b38:	c7 04 24 42 3a 10 00 	movl   $0x103a42,(%esp)
  101b3f:	e8 de e7 ff ff       	call   100322 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b44:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101b48:	d1 65 f0             	shll   -0x10(%ebp)
  101b4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b4e:	83 f8 17             	cmp    $0x17,%eax
  101b51:	76 ba                	jbe    101b0d <print_trapframe+0x120>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101b53:	8b 45 08             	mov    0x8(%ebp),%eax
  101b56:	8b 40 40             	mov    0x40(%eax),%eax
  101b59:	25 00 30 00 00       	and    $0x3000,%eax
  101b5e:	c1 e8 0c             	shr    $0xc,%eax
  101b61:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b65:	c7 04 24 46 3a 10 00 	movl   $0x103a46,(%esp)
  101b6c:	e8 b1 e7 ff ff       	call   100322 <cprintf>

    if (!trap_in_kernel(tf)) {
  101b71:	8b 45 08             	mov    0x8(%ebp),%eax
  101b74:	89 04 24             	mov    %eax,(%esp)
  101b77:	e8 5b fe ff ff       	call   1019d7 <trap_in_kernel>
  101b7c:	85 c0                	test   %eax,%eax
  101b7e:	75 30                	jne    101bb0 <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101b80:	8b 45 08             	mov    0x8(%ebp),%eax
  101b83:	8b 40 44             	mov    0x44(%eax),%eax
  101b86:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b8a:	c7 04 24 4f 3a 10 00 	movl   $0x103a4f,(%esp)
  101b91:	e8 8c e7 ff ff       	call   100322 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101b96:	8b 45 08             	mov    0x8(%ebp),%eax
  101b99:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101b9d:	0f b7 c0             	movzwl %ax,%eax
  101ba0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ba4:	c7 04 24 5e 3a 10 00 	movl   $0x103a5e,(%esp)
  101bab:	e8 72 e7 ff ff       	call   100322 <cprintf>
    }
}
  101bb0:	c9                   	leave  
  101bb1:	c3                   	ret    

00101bb2 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101bb2:	55                   	push   %ebp
  101bb3:	89 e5                	mov    %esp,%ebp
  101bb5:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101bb8:	8b 45 08             	mov    0x8(%ebp),%eax
  101bbb:	8b 00                	mov    (%eax),%eax
  101bbd:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bc1:	c7 04 24 71 3a 10 00 	movl   $0x103a71,(%esp)
  101bc8:	e8 55 e7 ff ff       	call   100322 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  101bd0:	8b 40 04             	mov    0x4(%eax),%eax
  101bd3:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bd7:	c7 04 24 80 3a 10 00 	movl   $0x103a80,(%esp)
  101bde:	e8 3f e7 ff ff       	call   100322 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101be3:	8b 45 08             	mov    0x8(%ebp),%eax
  101be6:	8b 40 08             	mov    0x8(%eax),%eax
  101be9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bed:	c7 04 24 8f 3a 10 00 	movl   $0x103a8f,(%esp)
  101bf4:	e8 29 e7 ff ff       	call   100322 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  101bfc:	8b 40 0c             	mov    0xc(%eax),%eax
  101bff:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c03:	c7 04 24 9e 3a 10 00 	movl   $0x103a9e,(%esp)
  101c0a:	e8 13 e7 ff ff       	call   100322 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  101c12:	8b 40 10             	mov    0x10(%eax),%eax
  101c15:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c19:	c7 04 24 ad 3a 10 00 	movl   $0x103aad,(%esp)
  101c20:	e8 fd e6 ff ff       	call   100322 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101c25:	8b 45 08             	mov    0x8(%ebp),%eax
  101c28:	8b 40 14             	mov    0x14(%eax),%eax
  101c2b:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c2f:	c7 04 24 bc 3a 10 00 	movl   $0x103abc,(%esp)
  101c36:	e8 e7 e6 ff ff       	call   100322 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101c3b:	8b 45 08             	mov    0x8(%ebp),%eax
  101c3e:	8b 40 18             	mov    0x18(%eax),%eax
  101c41:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c45:	c7 04 24 cb 3a 10 00 	movl   $0x103acb,(%esp)
  101c4c:	e8 d1 e6 ff ff       	call   100322 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101c51:	8b 45 08             	mov    0x8(%ebp),%eax
  101c54:	8b 40 1c             	mov    0x1c(%eax),%eax
  101c57:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c5b:	c7 04 24 da 3a 10 00 	movl   $0x103ada,(%esp)
  101c62:	e8 bb e6 ff ff       	call   100322 <cprintf>
}
  101c67:	c9                   	leave  
  101c68:	c3                   	ret    

00101c69 <trap_dispatch>:
/* temporary trapframe or pointer to trapframe */
struct trapframe switchk2u, *switchu2k;

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101c69:	55                   	push   %ebp
  101c6a:	89 e5                	mov    %esp,%ebp
  101c6c:	57                   	push   %edi
  101c6d:	56                   	push   %esi
  101c6e:	53                   	push   %ebx
  101c6f:	83 ec 2c             	sub    $0x2c,%esp
    char c;

    switch (tf->tf_trapno) {
  101c72:	8b 45 08             	mov    0x8(%ebp),%eax
  101c75:	8b 40 30             	mov    0x30(%eax),%eax
  101c78:	83 f8 2f             	cmp    $0x2f,%eax
  101c7b:	77 21                	ja     101c9e <trap_dispatch+0x35>
  101c7d:	83 f8 2e             	cmp    $0x2e,%eax
  101c80:	0f 83 ec 01 00 00    	jae    101e72 <trap_dispatch+0x209>
  101c86:	83 f8 21             	cmp    $0x21,%eax
  101c89:	0f 84 8a 00 00 00    	je     101d19 <trap_dispatch+0xb0>
  101c8f:	83 f8 24             	cmp    $0x24,%eax
  101c92:	74 5c                	je     101cf0 <trap_dispatch+0x87>
  101c94:	83 f8 20             	cmp    $0x20,%eax
  101c97:	74 1c                	je     101cb5 <trap_dispatch+0x4c>
  101c99:	e9 9c 01 00 00       	jmp    101e3a <trap_dispatch+0x1d1>
  101c9e:	83 f8 78             	cmp    $0x78,%eax
  101ca1:	0f 84 9b 00 00 00    	je     101d42 <trap_dispatch+0xd9>
  101ca7:	83 f8 79             	cmp    $0x79,%eax
  101caa:	0f 84 11 01 00 00    	je     101dc1 <trap_dispatch+0x158>
  101cb0:	e9 85 01 00 00       	jmp    101e3a <trap_dispatch+0x1d1>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ticks ++;
  101cb5:	a1 08 f9 10 00       	mov    0x10f908,%eax
  101cba:	83 c0 01             	add    $0x1,%eax
  101cbd:	a3 08 f9 10 00       	mov    %eax,0x10f908
        if (ticks % TICK_NUM == 0) {
  101cc2:	8b 0d 08 f9 10 00    	mov    0x10f908,%ecx
  101cc8:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101ccd:	89 c8                	mov    %ecx,%eax
  101ccf:	f7 e2                	mul    %edx
  101cd1:	89 d0                	mov    %edx,%eax
  101cd3:	c1 e8 05             	shr    $0x5,%eax
  101cd6:	6b c0 64             	imul   $0x64,%eax,%eax
  101cd9:	29 c1                	sub    %eax,%ecx
  101cdb:	89 c8                	mov    %ecx,%eax
  101cdd:	85 c0                	test   %eax,%eax
  101cdf:	75 0a                	jne    101ceb <trap_dispatch+0x82>
            print_ticks();
  101ce1:	e8 0d fb ff ff       	call   1017f3 <print_ticks>
        }
        break;
  101ce6:	e9 88 01 00 00       	jmp    101e73 <trap_dispatch+0x20a>
  101ceb:	e9 83 01 00 00       	jmp    101e73 <trap_dispatch+0x20a>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101cf0:	e8 d5 f8 ff ff       	call   1015ca <cons_getc>
  101cf5:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101cf8:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101cfc:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101d00:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d04:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d08:	c7 04 24 e9 3a 10 00 	movl   $0x103ae9,(%esp)
  101d0f:	e8 0e e6 ff ff       	call   100322 <cprintf>
        break;
  101d14:	e9 5a 01 00 00       	jmp    101e73 <trap_dispatch+0x20a>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101d19:	e8 ac f8 ff ff       	call   1015ca <cons_getc>
  101d1e:	88 45 e7             	mov    %al,-0x19(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101d21:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
  101d25:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  101d29:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d2d:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d31:	c7 04 24 fb 3a 10 00 	movl   $0x103afb,(%esp)
  101d38:	e8 e5 e5 ff ff       	call   100322 <cprintf>
        break;
  101d3d:	e9 31 01 00 00       	jmp    101e73 <trap_dispatch+0x20a>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
        if (tf->tf_cs != USER_CS) {
  101d42:	8b 45 08             	mov    0x8(%ebp),%eax
  101d45:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101d49:	66 83 f8 1b          	cmp    $0x1b,%ax
  101d4d:	74 6d                	je     101dbc <trap_dispatch+0x153>
            switchk2u = *tf;
  101d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  101d52:	ba 20 f9 10 00       	mov    $0x10f920,%edx
  101d57:	89 c3                	mov    %eax,%ebx
  101d59:	b8 13 00 00 00       	mov    $0x13,%eax
  101d5e:	89 d7                	mov    %edx,%edi
  101d60:	89 de                	mov    %ebx,%esi
  101d62:	89 c1                	mov    %eax,%ecx
  101d64:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
            switchk2u.tf_cs = USER_CS;
  101d66:	66 c7 05 5c f9 10 00 	movw   $0x1b,0x10f95c
  101d6d:	1b 00 
            switchk2u.tf_ds = switchk2u.tf_es = switchk2u.tf_ss = USER_DS;
  101d6f:	66 c7 05 68 f9 10 00 	movw   $0x23,0x10f968
  101d76:	23 00 
  101d78:	0f b7 05 68 f9 10 00 	movzwl 0x10f968,%eax
  101d7f:	66 a3 48 f9 10 00    	mov    %ax,0x10f948
  101d85:	0f b7 05 48 f9 10 00 	movzwl 0x10f948,%eax
  101d8c:	66 a3 4c f9 10 00    	mov    %ax,0x10f94c
            switchk2u.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;
  101d92:	8b 45 08             	mov    0x8(%ebp),%eax
  101d95:	83 c0 44             	add    $0x44,%eax
  101d98:	a3 64 f9 10 00       	mov    %eax,0x10f964
		
            // set eflags, make sure ucore can use io under user mode.
            // if CPL > IOPL, then cpu will generate a general protection.
            switchk2u.tf_eflags |= FL_IOPL_MASK;
  101d9d:	a1 60 f9 10 00       	mov    0x10f960,%eax
  101da2:	80 cc 30             	or     $0x30,%ah
  101da5:	a3 60 f9 10 00       	mov    %eax,0x10f960
		
            // set temporary stack
            // then iret will jump to the right stack
            *((uint32_t *)tf - 1) = (uint32_t)&switchk2u;
  101daa:	8b 45 08             	mov    0x8(%ebp),%eax
  101dad:	8d 50 fc             	lea    -0x4(%eax),%edx
  101db0:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  101db5:	89 02                	mov    %eax,(%edx)
        }
        break;
  101db7:	e9 b7 00 00 00       	jmp    101e73 <trap_dispatch+0x20a>
  101dbc:	e9 b2 00 00 00       	jmp    101e73 <trap_dispatch+0x20a>
    case T_SWITCH_TOK:
        if (tf->tf_cs != KERNEL_CS) {
  101dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  101dc4:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101dc8:	66 83 f8 08          	cmp    $0x8,%ax
  101dcc:	74 6a                	je     101e38 <trap_dispatch+0x1cf>
            tf->tf_cs = KERNEL_CS;
  101dce:	8b 45 08             	mov    0x8(%ebp),%eax
  101dd1:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
            tf->tf_ds = tf->tf_es = KERNEL_DS;
  101dd7:	8b 45 08             	mov    0x8(%ebp),%eax
  101dda:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
  101de0:	8b 45 08             	mov    0x8(%ebp),%eax
  101de3:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101de7:	8b 45 08             	mov    0x8(%ebp),%eax
  101dea:	66 89 50 2c          	mov    %dx,0x2c(%eax)
            tf->tf_eflags &= ~FL_IOPL_MASK;
  101dee:	8b 45 08             	mov    0x8(%ebp),%eax
  101df1:	8b 40 40             	mov    0x40(%eax),%eax
  101df4:	80 e4 cf             	and    $0xcf,%ah
  101df7:	89 c2                	mov    %eax,%edx
  101df9:	8b 45 08             	mov    0x8(%ebp),%eax
  101dfc:	89 50 40             	mov    %edx,0x40(%eax)
            switchu2k = (struct trapframe *)(tf->tf_esp - (sizeof(struct trapframe) - 8));
  101dff:	8b 45 08             	mov    0x8(%ebp),%eax
  101e02:	8b 40 44             	mov    0x44(%eax),%eax
  101e05:	83 e8 44             	sub    $0x44,%eax
  101e08:	a3 6c f9 10 00       	mov    %eax,0x10f96c
            memmove(switchu2k, tf, sizeof(struct trapframe) - 8);
  101e0d:	a1 6c f9 10 00       	mov    0x10f96c,%eax
  101e12:	c7 44 24 08 44 00 00 	movl   $0x44,0x8(%esp)
  101e19:	00 
  101e1a:	8b 55 08             	mov    0x8(%ebp),%edx
  101e1d:	89 54 24 04          	mov    %edx,0x4(%esp)
  101e21:	89 04 24             	mov    %eax,(%esp)
  101e24:	e8 25 16 00 00       	call   10344e <memmove>
            *((uint32_t *)tf - 1) = (uint32_t)switchu2k;
  101e29:	8b 45 08             	mov    0x8(%ebp),%eax
  101e2c:	8d 50 fc             	lea    -0x4(%eax),%edx
  101e2f:	a1 6c f9 10 00       	mov    0x10f96c,%eax
  101e34:	89 02                	mov    %eax,(%edx)
        }
        break;
  101e36:	eb 3b                	jmp    101e73 <trap_dispatch+0x20a>
  101e38:	eb 39                	jmp    101e73 <trap_dispatch+0x20a>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101e3a:	8b 45 08             	mov    0x8(%ebp),%eax
  101e3d:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101e41:	0f b7 c0             	movzwl %ax,%eax
  101e44:	83 e0 03             	and    $0x3,%eax
  101e47:	85 c0                	test   %eax,%eax
  101e49:	75 28                	jne    101e73 <trap_dispatch+0x20a>
            print_trapframe(tf);
  101e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  101e4e:	89 04 24             	mov    %eax,(%esp)
  101e51:	e8 97 fb ff ff       	call   1019ed <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101e56:	c7 44 24 08 0a 3b 10 	movl   $0x103b0a,0x8(%esp)
  101e5d:	00 
  101e5e:	c7 44 24 04 d2 00 00 	movl   $0xd2,0x4(%esp)
  101e65:	00 
  101e66:	c7 04 24 2e 39 10 00 	movl   $0x10392e,(%esp)
  101e6d:	e8 3a ee ff ff       	call   100cac <__panic>
        }
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
  101e72:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
  101e73:	83 c4 2c             	add    $0x2c,%esp
  101e76:	5b                   	pop    %ebx
  101e77:	5e                   	pop    %esi
  101e78:	5f                   	pop    %edi
  101e79:	5d                   	pop    %ebp
  101e7a:	c3                   	ret    

00101e7b <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101e7b:	55                   	push   %ebp
  101e7c:	89 e5                	mov    %esp,%ebp
  101e7e:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101e81:	8b 45 08             	mov    0x8(%ebp),%eax
  101e84:	89 04 24             	mov    %eax,(%esp)
  101e87:	e8 dd fd ff ff       	call   101c69 <trap_dispatch>
}
  101e8c:	c9                   	leave  
  101e8d:	c3                   	ret    

00101e8e <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  101e8e:	1e                   	push   %ds
    pushl %es
  101e8f:	06                   	push   %es
    pushl %fs
  101e90:	0f a0                	push   %fs
    pushl %gs
  101e92:	0f a8                	push   %gs
    pushal
  101e94:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  101e95:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  101e9a:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  101e9c:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  101e9e:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  101e9f:	e8 d7 ff ff ff       	call   101e7b <trap>

    # pop the pushed stack pointer
    popl %esp
  101ea4:	5c                   	pop    %esp

00101ea5 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  101ea5:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  101ea6:	0f a9                	pop    %gs
    popl %fs
  101ea8:	0f a1                	pop    %fs
    popl %es
  101eaa:	07                   	pop    %es
    popl %ds
  101eab:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  101eac:	83 c4 08             	add    $0x8,%esp
    iret
  101eaf:	cf                   	iret   

00101eb0 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101eb0:	6a 00                	push   $0x0
  pushl $0
  101eb2:	6a 00                	push   $0x0
  jmp __alltraps
  101eb4:	e9 d5 ff ff ff       	jmp    101e8e <__alltraps>

00101eb9 <vector1>:
.globl vector1
vector1:
  pushl $0
  101eb9:	6a 00                	push   $0x0
  pushl $1
  101ebb:	6a 01                	push   $0x1
  jmp __alltraps
  101ebd:	e9 cc ff ff ff       	jmp    101e8e <__alltraps>

00101ec2 <vector2>:
.globl vector2
vector2:
  pushl $0
  101ec2:	6a 00                	push   $0x0
  pushl $2
  101ec4:	6a 02                	push   $0x2
  jmp __alltraps
  101ec6:	e9 c3 ff ff ff       	jmp    101e8e <__alltraps>

00101ecb <vector3>:
.globl vector3
vector3:
  pushl $0
  101ecb:	6a 00                	push   $0x0
  pushl $3
  101ecd:	6a 03                	push   $0x3
  jmp __alltraps
  101ecf:	e9 ba ff ff ff       	jmp    101e8e <__alltraps>

00101ed4 <vector4>:
.globl vector4
vector4:
  pushl $0
  101ed4:	6a 00                	push   $0x0
  pushl $4
  101ed6:	6a 04                	push   $0x4
  jmp __alltraps
  101ed8:	e9 b1 ff ff ff       	jmp    101e8e <__alltraps>

00101edd <vector5>:
.globl vector5
vector5:
  pushl $0
  101edd:	6a 00                	push   $0x0
  pushl $5
  101edf:	6a 05                	push   $0x5
  jmp __alltraps
  101ee1:	e9 a8 ff ff ff       	jmp    101e8e <__alltraps>

00101ee6 <vector6>:
.globl vector6
vector6:
  pushl $0
  101ee6:	6a 00                	push   $0x0
  pushl $6
  101ee8:	6a 06                	push   $0x6
  jmp __alltraps
  101eea:	e9 9f ff ff ff       	jmp    101e8e <__alltraps>

00101eef <vector7>:
.globl vector7
vector7:
  pushl $0
  101eef:	6a 00                	push   $0x0
  pushl $7
  101ef1:	6a 07                	push   $0x7
  jmp __alltraps
  101ef3:	e9 96 ff ff ff       	jmp    101e8e <__alltraps>

00101ef8 <vector8>:
.globl vector8
vector8:
  pushl $8
  101ef8:	6a 08                	push   $0x8
  jmp __alltraps
  101efa:	e9 8f ff ff ff       	jmp    101e8e <__alltraps>

00101eff <vector9>:
.globl vector9
vector9:
  pushl $9
  101eff:	6a 09                	push   $0x9
  jmp __alltraps
  101f01:	e9 88 ff ff ff       	jmp    101e8e <__alltraps>

00101f06 <vector10>:
.globl vector10
vector10:
  pushl $10
  101f06:	6a 0a                	push   $0xa
  jmp __alltraps
  101f08:	e9 81 ff ff ff       	jmp    101e8e <__alltraps>

00101f0d <vector11>:
.globl vector11
vector11:
  pushl $11
  101f0d:	6a 0b                	push   $0xb
  jmp __alltraps
  101f0f:	e9 7a ff ff ff       	jmp    101e8e <__alltraps>

00101f14 <vector12>:
.globl vector12
vector12:
  pushl $12
  101f14:	6a 0c                	push   $0xc
  jmp __alltraps
  101f16:	e9 73 ff ff ff       	jmp    101e8e <__alltraps>

00101f1b <vector13>:
.globl vector13
vector13:
  pushl $13
  101f1b:	6a 0d                	push   $0xd
  jmp __alltraps
  101f1d:	e9 6c ff ff ff       	jmp    101e8e <__alltraps>

00101f22 <vector14>:
.globl vector14
vector14:
  pushl $14
  101f22:	6a 0e                	push   $0xe
  jmp __alltraps
  101f24:	e9 65 ff ff ff       	jmp    101e8e <__alltraps>

00101f29 <vector15>:
.globl vector15
vector15:
  pushl $0
  101f29:	6a 00                	push   $0x0
  pushl $15
  101f2b:	6a 0f                	push   $0xf
  jmp __alltraps
  101f2d:	e9 5c ff ff ff       	jmp    101e8e <__alltraps>

00101f32 <vector16>:
.globl vector16
vector16:
  pushl $0
  101f32:	6a 00                	push   $0x0
  pushl $16
  101f34:	6a 10                	push   $0x10
  jmp __alltraps
  101f36:	e9 53 ff ff ff       	jmp    101e8e <__alltraps>

00101f3b <vector17>:
.globl vector17
vector17:
  pushl $17
  101f3b:	6a 11                	push   $0x11
  jmp __alltraps
  101f3d:	e9 4c ff ff ff       	jmp    101e8e <__alltraps>

00101f42 <vector18>:
.globl vector18
vector18:
  pushl $0
  101f42:	6a 00                	push   $0x0
  pushl $18
  101f44:	6a 12                	push   $0x12
  jmp __alltraps
  101f46:	e9 43 ff ff ff       	jmp    101e8e <__alltraps>

00101f4b <vector19>:
.globl vector19
vector19:
  pushl $0
  101f4b:	6a 00                	push   $0x0
  pushl $19
  101f4d:	6a 13                	push   $0x13
  jmp __alltraps
  101f4f:	e9 3a ff ff ff       	jmp    101e8e <__alltraps>

00101f54 <vector20>:
.globl vector20
vector20:
  pushl $0
  101f54:	6a 00                	push   $0x0
  pushl $20
  101f56:	6a 14                	push   $0x14
  jmp __alltraps
  101f58:	e9 31 ff ff ff       	jmp    101e8e <__alltraps>

00101f5d <vector21>:
.globl vector21
vector21:
  pushl $0
  101f5d:	6a 00                	push   $0x0
  pushl $21
  101f5f:	6a 15                	push   $0x15
  jmp __alltraps
  101f61:	e9 28 ff ff ff       	jmp    101e8e <__alltraps>

00101f66 <vector22>:
.globl vector22
vector22:
  pushl $0
  101f66:	6a 00                	push   $0x0
  pushl $22
  101f68:	6a 16                	push   $0x16
  jmp __alltraps
  101f6a:	e9 1f ff ff ff       	jmp    101e8e <__alltraps>

00101f6f <vector23>:
.globl vector23
vector23:
  pushl $0
  101f6f:	6a 00                	push   $0x0
  pushl $23
  101f71:	6a 17                	push   $0x17
  jmp __alltraps
  101f73:	e9 16 ff ff ff       	jmp    101e8e <__alltraps>

00101f78 <vector24>:
.globl vector24
vector24:
  pushl $0
  101f78:	6a 00                	push   $0x0
  pushl $24
  101f7a:	6a 18                	push   $0x18
  jmp __alltraps
  101f7c:	e9 0d ff ff ff       	jmp    101e8e <__alltraps>

00101f81 <vector25>:
.globl vector25
vector25:
  pushl $0
  101f81:	6a 00                	push   $0x0
  pushl $25
  101f83:	6a 19                	push   $0x19
  jmp __alltraps
  101f85:	e9 04 ff ff ff       	jmp    101e8e <__alltraps>

00101f8a <vector26>:
.globl vector26
vector26:
  pushl $0
  101f8a:	6a 00                	push   $0x0
  pushl $26
  101f8c:	6a 1a                	push   $0x1a
  jmp __alltraps
  101f8e:	e9 fb fe ff ff       	jmp    101e8e <__alltraps>

00101f93 <vector27>:
.globl vector27
vector27:
  pushl $0
  101f93:	6a 00                	push   $0x0
  pushl $27
  101f95:	6a 1b                	push   $0x1b
  jmp __alltraps
  101f97:	e9 f2 fe ff ff       	jmp    101e8e <__alltraps>

00101f9c <vector28>:
.globl vector28
vector28:
  pushl $0
  101f9c:	6a 00                	push   $0x0
  pushl $28
  101f9e:	6a 1c                	push   $0x1c
  jmp __alltraps
  101fa0:	e9 e9 fe ff ff       	jmp    101e8e <__alltraps>

00101fa5 <vector29>:
.globl vector29
vector29:
  pushl $0
  101fa5:	6a 00                	push   $0x0
  pushl $29
  101fa7:	6a 1d                	push   $0x1d
  jmp __alltraps
  101fa9:	e9 e0 fe ff ff       	jmp    101e8e <__alltraps>

00101fae <vector30>:
.globl vector30
vector30:
  pushl $0
  101fae:	6a 00                	push   $0x0
  pushl $30
  101fb0:	6a 1e                	push   $0x1e
  jmp __alltraps
  101fb2:	e9 d7 fe ff ff       	jmp    101e8e <__alltraps>

00101fb7 <vector31>:
.globl vector31
vector31:
  pushl $0
  101fb7:	6a 00                	push   $0x0
  pushl $31
  101fb9:	6a 1f                	push   $0x1f
  jmp __alltraps
  101fbb:	e9 ce fe ff ff       	jmp    101e8e <__alltraps>

00101fc0 <vector32>:
.globl vector32
vector32:
  pushl $0
  101fc0:	6a 00                	push   $0x0
  pushl $32
  101fc2:	6a 20                	push   $0x20
  jmp __alltraps
  101fc4:	e9 c5 fe ff ff       	jmp    101e8e <__alltraps>

00101fc9 <vector33>:
.globl vector33
vector33:
  pushl $0
  101fc9:	6a 00                	push   $0x0
  pushl $33
  101fcb:	6a 21                	push   $0x21
  jmp __alltraps
  101fcd:	e9 bc fe ff ff       	jmp    101e8e <__alltraps>

00101fd2 <vector34>:
.globl vector34
vector34:
  pushl $0
  101fd2:	6a 00                	push   $0x0
  pushl $34
  101fd4:	6a 22                	push   $0x22
  jmp __alltraps
  101fd6:	e9 b3 fe ff ff       	jmp    101e8e <__alltraps>

00101fdb <vector35>:
.globl vector35
vector35:
  pushl $0
  101fdb:	6a 00                	push   $0x0
  pushl $35
  101fdd:	6a 23                	push   $0x23
  jmp __alltraps
  101fdf:	e9 aa fe ff ff       	jmp    101e8e <__alltraps>

00101fe4 <vector36>:
.globl vector36
vector36:
  pushl $0
  101fe4:	6a 00                	push   $0x0
  pushl $36
  101fe6:	6a 24                	push   $0x24
  jmp __alltraps
  101fe8:	e9 a1 fe ff ff       	jmp    101e8e <__alltraps>

00101fed <vector37>:
.globl vector37
vector37:
  pushl $0
  101fed:	6a 00                	push   $0x0
  pushl $37
  101fef:	6a 25                	push   $0x25
  jmp __alltraps
  101ff1:	e9 98 fe ff ff       	jmp    101e8e <__alltraps>

00101ff6 <vector38>:
.globl vector38
vector38:
  pushl $0
  101ff6:	6a 00                	push   $0x0
  pushl $38
  101ff8:	6a 26                	push   $0x26
  jmp __alltraps
  101ffa:	e9 8f fe ff ff       	jmp    101e8e <__alltraps>

00101fff <vector39>:
.globl vector39
vector39:
  pushl $0
  101fff:	6a 00                	push   $0x0
  pushl $39
  102001:	6a 27                	push   $0x27
  jmp __alltraps
  102003:	e9 86 fe ff ff       	jmp    101e8e <__alltraps>

00102008 <vector40>:
.globl vector40
vector40:
  pushl $0
  102008:	6a 00                	push   $0x0
  pushl $40
  10200a:	6a 28                	push   $0x28
  jmp __alltraps
  10200c:	e9 7d fe ff ff       	jmp    101e8e <__alltraps>

00102011 <vector41>:
.globl vector41
vector41:
  pushl $0
  102011:	6a 00                	push   $0x0
  pushl $41
  102013:	6a 29                	push   $0x29
  jmp __alltraps
  102015:	e9 74 fe ff ff       	jmp    101e8e <__alltraps>

0010201a <vector42>:
.globl vector42
vector42:
  pushl $0
  10201a:	6a 00                	push   $0x0
  pushl $42
  10201c:	6a 2a                	push   $0x2a
  jmp __alltraps
  10201e:	e9 6b fe ff ff       	jmp    101e8e <__alltraps>

00102023 <vector43>:
.globl vector43
vector43:
  pushl $0
  102023:	6a 00                	push   $0x0
  pushl $43
  102025:	6a 2b                	push   $0x2b
  jmp __alltraps
  102027:	e9 62 fe ff ff       	jmp    101e8e <__alltraps>

0010202c <vector44>:
.globl vector44
vector44:
  pushl $0
  10202c:	6a 00                	push   $0x0
  pushl $44
  10202e:	6a 2c                	push   $0x2c
  jmp __alltraps
  102030:	e9 59 fe ff ff       	jmp    101e8e <__alltraps>

00102035 <vector45>:
.globl vector45
vector45:
  pushl $0
  102035:	6a 00                	push   $0x0
  pushl $45
  102037:	6a 2d                	push   $0x2d
  jmp __alltraps
  102039:	e9 50 fe ff ff       	jmp    101e8e <__alltraps>

0010203e <vector46>:
.globl vector46
vector46:
  pushl $0
  10203e:	6a 00                	push   $0x0
  pushl $46
  102040:	6a 2e                	push   $0x2e
  jmp __alltraps
  102042:	e9 47 fe ff ff       	jmp    101e8e <__alltraps>

00102047 <vector47>:
.globl vector47
vector47:
  pushl $0
  102047:	6a 00                	push   $0x0
  pushl $47
  102049:	6a 2f                	push   $0x2f
  jmp __alltraps
  10204b:	e9 3e fe ff ff       	jmp    101e8e <__alltraps>

00102050 <vector48>:
.globl vector48
vector48:
  pushl $0
  102050:	6a 00                	push   $0x0
  pushl $48
  102052:	6a 30                	push   $0x30
  jmp __alltraps
  102054:	e9 35 fe ff ff       	jmp    101e8e <__alltraps>

00102059 <vector49>:
.globl vector49
vector49:
  pushl $0
  102059:	6a 00                	push   $0x0
  pushl $49
  10205b:	6a 31                	push   $0x31
  jmp __alltraps
  10205d:	e9 2c fe ff ff       	jmp    101e8e <__alltraps>

00102062 <vector50>:
.globl vector50
vector50:
  pushl $0
  102062:	6a 00                	push   $0x0
  pushl $50
  102064:	6a 32                	push   $0x32
  jmp __alltraps
  102066:	e9 23 fe ff ff       	jmp    101e8e <__alltraps>

0010206b <vector51>:
.globl vector51
vector51:
  pushl $0
  10206b:	6a 00                	push   $0x0
  pushl $51
  10206d:	6a 33                	push   $0x33
  jmp __alltraps
  10206f:	e9 1a fe ff ff       	jmp    101e8e <__alltraps>

00102074 <vector52>:
.globl vector52
vector52:
  pushl $0
  102074:	6a 00                	push   $0x0
  pushl $52
  102076:	6a 34                	push   $0x34
  jmp __alltraps
  102078:	e9 11 fe ff ff       	jmp    101e8e <__alltraps>

0010207d <vector53>:
.globl vector53
vector53:
  pushl $0
  10207d:	6a 00                	push   $0x0
  pushl $53
  10207f:	6a 35                	push   $0x35
  jmp __alltraps
  102081:	e9 08 fe ff ff       	jmp    101e8e <__alltraps>

00102086 <vector54>:
.globl vector54
vector54:
  pushl $0
  102086:	6a 00                	push   $0x0
  pushl $54
  102088:	6a 36                	push   $0x36
  jmp __alltraps
  10208a:	e9 ff fd ff ff       	jmp    101e8e <__alltraps>

0010208f <vector55>:
.globl vector55
vector55:
  pushl $0
  10208f:	6a 00                	push   $0x0
  pushl $55
  102091:	6a 37                	push   $0x37
  jmp __alltraps
  102093:	e9 f6 fd ff ff       	jmp    101e8e <__alltraps>

00102098 <vector56>:
.globl vector56
vector56:
  pushl $0
  102098:	6a 00                	push   $0x0
  pushl $56
  10209a:	6a 38                	push   $0x38
  jmp __alltraps
  10209c:	e9 ed fd ff ff       	jmp    101e8e <__alltraps>

001020a1 <vector57>:
.globl vector57
vector57:
  pushl $0
  1020a1:	6a 00                	push   $0x0
  pushl $57
  1020a3:	6a 39                	push   $0x39
  jmp __alltraps
  1020a5:	e9 e4 fd ff ff       	jmp    101e8e <__alltraps>

001020aa <vector58>:
.globl vector58
vector58:
  pushl $0
  1020aa:	6a 00                	push   $0x0
  pushl $58
  1020ac:	6a 3a                	push   $0x3a
  jmp __alltraps
  1020ae:	e9 db fd ff ff       	jmp    101e8e <__alltraps>

001020b3 <vector59>:
.globl vector59
vector59:
  pushl $0
  1020b3:	6a 00                	push   $0x0
  pushl $59
  1020b5:	6a 3b                	push   $0x3b
  jmp __alltraps
  1020b7:	e9 d2 fd ff ff       	jmp    101e8e <__alltraps>

001020bc <vector60>:
.globl vector60
vector60:
  pushl $0
  1020bc:	6a 00                	push   $0x0
  pushl $60
  1020be:	6a 3c                	push   $0x3c
  jmp __alltraps
  1020c0:	e9 c9 fd ff ff       	jmp    101e8e <__alltraps>

001020c5 <vector61>:
.globl vector61
vector61:
  pushl $0
  1020c5:	6a 00                	push   $0x0
  pushl $61
  1020c7:	6a 3d                	push   $0x3d
  jmp __alltraps
  1020c9:	e9 c0 fd ff ff       	jmp    101e8e <__alltraps>

001020ce <vector62>:
.globl vector62
vector62:
  pushl $0
  1020ce:	6a 00                	push   $0x0
  pushl $62
  1020d0:	6a 3e                	push   $0x3e
  jmp __alltraps
  1020d2:	e9 b7 fd ff ff       	jmp    101e8e <__alltraps>

001020d7 <vector63>:
.globl vector63
vector63:
  pushl $0
  1020d7:	6a 00                	push   $0x0
  pushl $63
  1020d9:	6a 3f                	push   $0x3f
  jmp __alltraps
  1020db:	e9 ae fd ff ff       	jmp    101e8e <__alltraps>

001020e0 <vector64>:
.globl vector64
vector64:
  pushl $0
  1020e0:	6a 00                	push   $0x0
  pushl $64
  1020e2:	6a 40                	push   $0x40
  jmp __alltraps
  1020e4:	e9 a5 fd ff ff       	jmp    101e8e <__alltraps>

001020e9 <vector65>:
.globl vector65
vector65:
  pushl $0
  1020e9:	6a 00                	push   $0x0
  pushl $65
  1020eb:	6a 41                	push   $0x41
  jmp __alltraps
  1020ed:	e9 9c fd ff ff       	jmp    101e8e <__alltraps>

001020f2 <vector66>:
.globl vector66
vector66:
  pushl $0
  1020f2:	6a 00                	push   $0x0
  pushl $66
  1020f4:	6a 42                	push   $0x42
  jmp __alltraps
  1020f6:	e9 93 fd ff ff       	jmp    101e8e <__alltraps>

001020fb <vector67>:
.globl vector67
vector67:
  pushl $0
  1020fb:	6a 00                	push   $0x0
  pushl $67
  1020fd:	6a 43                	push   $0x43
  jmp __alltraps
  1020ff:	e9 8a fd ff ff       	jmp    101e8e <__alltraps>

00102104 <vector68>:
.globl vector68
vector68:
  pushl $0
  102104:	6a 00                	push   $0x0
  pushl $68
  102106:	6a 44                	push   $0x44
  jmp __alltraps
  102108:	e9 81 fd ff ff       	jmp    101e8e <__alltraps>

0010210d <vector69>:
.globl vector69
vector69:
  pushl $0
  10210d:	6a 00                	push   $0x0
  pushl $69
  10210f:	6a 45                	push   $0x45
  jmp __alltraps
  102111:	e9 78 fd ff ff       	jmp    101e8e <__alltraps>

00102116 <vector70>:
.globl vector70
vector70:
  pushl $0
  102116:	6a 00                	push   $0x0
  pushl $70
  102118:	6a 46                	push   $0x46
  jmp __alltraps
  10211a:	e9 6f fd ff ff       	jmp    101e8e <__alltraps>

0010211f <vector71>:
.globl vector71
vector71:
  pushl $0
  10211f:	6a 00                	push   $0x0
  pushl $71
  102121:	6a 47                	push   $0x47
  jmp __alltraps
  102123:	e9 66 fd ff ff       	jmp    101e8e <__alltraps>

00102128 <vector72>:
.globl vector72
vector72:
  pushl $0
  102128:	6a 00                	push   $0x0
  pushl $72
  10212a:	6a 48                	push   $0x48
  jmp __alltraps
  10212c:	e9 5d fd ff ff       	jmp    101e8e <__alltraps>

00102131 <vector73>:
.globl vector73
vector73:
  pushl $0
  102131:	6a 00                	push   $0x0
  pushl $73
  102133:	6a 49                	push   $0x49
  jmp __alltraps
  102135:	e9 54 fd ff ff       	jmp    101e8e <__alltraps>

0010213a <vector74>:
.globl vector74
vector74:
  pushl $0
  10213a:	6a 00                	push   $0x0
  pushl $74
  10213c:	6a 4a                	push   $0x4a
  jmp __alltraps
  10213e:	e9 4b fd ff ff       	jmp    101e8e <__alltraps>

00102143 <vector75>:
.globl vector75
vector75:
  pushl $0
  102143:	6a 00                	push   $0x0
  pushl $75
  102145:	6a 4b                	push   $0x4b
  jmp __alltraps
  102147:	e9 42 fd ff ff       	jmp    101e8e <__alltraps>

0010214c <vector76>:
.globl vector76
vector76:
  pushl $0
  10214c:	6a 00                	push   $0x0
  pushl $76
  10214e:	6a 4c                	push   $0x4c
  jmp __alltraps
  102150:	e9 39 fd ff ff       	jmp    101e8e <__alltraps>

00102155 <vector77>:
.globl vector77
vector77:
  pushl $0
  102155:	6a 00                	push   $0x0
  pushl $77
  102157:	6a 4d                	push   $0x4d
  jmp __alltraps
  102159:	e9 30 fd ff ff       	jmp    101e8e <__alltraps>

0010215e <vector78>:
.globl vector78
vector78:
  pushl $0
  10215e:	6a 00                	push   $0x0
  pushl $78
  102160:	6a 4e                	push   $0x4e
  jmp __alltraps
  102162:	e9 27 fd ff ff       	jmp    101e8e <__alltraps>

00102167 <vector79>:
.globl vector79
vector79:
  pushl $0
  102167:	6a 00                	push   $0x0
  pushl $79
  102169:	6a 4f                	push   $0x4f
  jmp __alltraps
  10216b:	e9 1e fd ff ff       	jmp    101e8e <__alltraps>

00102170 <vector80>:
.globl vector80
vector80:
  pushl $0
  102170:	6a 00                	push   $0x0
  pushl $80
  102172:	6a 50                	push   $0x50
  jmp __alltraps
  102174:	e9 15 fd ff ff       	jmp    101e8e <__alltraps>

00102179 <vector81>:
.globl vector81
vector81:
  pushl $0
  102179:	6a 00                	push   $0x0
  pushl $81
  10217b:	6a 51                	push   $0x51
  jmp __alltraps
  10217d:	e9 0c fd ff ff       	jmp    101e8e <__alltraps>

00102182 <vector82>:
.globl vector82
vector82:
  pushl $0
  102182:	6a 00                	push   $0x0
  pushl $82
  102184:	6a 52                	push   $0x52
  jmp __alltraps
  102186:	e9 03 fd ff ff       	jmp    101e8e <__alltraps>

0010218b <vector83>:
.globl vector83
vector83:
  pushl $0
  10218b:	6a 00                	push   $0x0
  pushl $83
  10218d:	6a 53                	push   $0x53
  jmp __alltraps
  10218f:	e9 fa fc ff ff       	jmp    101e8e <__alltraps>

00102194 <vector84>:
.globl vector84
vector84:
  pushl $0
  102194:	6a 00                	push   $0x0
  pushl $84
  102196:	6a 54                	push   $0x54
  jmp __alltraps
  102198:	e9 f1 fc ff ff       	jmp    101e8e <__alltraps>

0010219d <vector85>:
.globl vector85
vector85:
  pushl $0
  10219d:	6a 00                	push   $0x0
  pushl $85
  10219f:	6a 55                	push   $0x55
  jmp __alltraps
  1021a1:	e9 e8 fc ff ff       	jmp    101e8e <__alltraps>

001021a6 <vector86>:
.globl vector86
vector86:
  pushl $0
  1021a6:	6a 00                	push   $0x0
  pushl $86
  1021a8:	6a 56                	push   $0x56
  jmp __alltraps
  1021aa:	e9 df fc ff ff       	jmp    101e8e <__alltraps>

001021af <vector87>:
.globl vector87
vector87:
  pushl $0
  1021af:	6a 00                	push   $0x0
  pushl $87
  1021b1:	6a 57                	push   $0x57
  jmp __alltraps
  1021b3:	e9 d6 fc ff ff       	jmp    101e8e <__alltraps>

001021b8 <vector88>:
.globl vector88
vector88:
  pushl $0
  1021b8:	6a 00                	push   $0x0
  pushl $88
  1021ba:	6a 58                	push   $0x58
  jmp __alltraps
  1021bc:	e9 cd fc ff ff       	jmp    101e8e <__alltraps>

001021c1 <vector89>:
.globl vector89
vector89:
  pushl $0
  1021c1:	6a 00                	push   $0x0
  pushl $89
  1021c3:	6a 59                	push   $0x59
  jmp __alltraps
  1021c5:	e9 c4 fc ff ff       	jmp    101e8e <__alltraps>

001021ca <vector90>:
.globl vector90
vector90:
  pushl $0
  1021ca:	6a 00                	push   $0x0
  pushl $90
  1021cc:	6a 5a                	push   $0x5a
  jmp __alltraps
  1021ce:	e9 bb fc ff ff       	jmp    101e8e <__alltraps>

001021d3 <vector91>:
.globl vector91
vector91:
  pushl $0
  1021d3:	6a 00                	push   $0x0
  pushl $91
  1021d5:	6a 5b                	push   $0x5b
  jmp __alltraps
  1021d7:	e9 b2 fc ff ff       	jmp    101e8e <__alltraps>

001021dc <vector92>:
.globl vector92
vector92:
  pushl $0
  1021dc:	6a 00                	push   $0x0
  pushl $92
  1021de:	6a 5c                	push   $0x5c
  jmp __alltraps
  1021e0:	e9 a9 fc ff ff       	jmp    101e8e <__alltraps>

001021e5 <vector93>:
.globl vector93
vector93:
  pushl $0
  1021e5:	6a 00                	push   $0x0
  pushl $93
  1021e7:	6a 5d                	push   $0x5d
  jmp __alltraps
  1021e9:	e9 a0 fc ff ff       	jmp    101e8e <__alltraps>

001021ee <vector94>:
.globl vector94
vector94:
  pushl $0
  1021ee:	6a 00                	push   $0x0
  pushl $94
  1021f0:	6a 5e                	push   $0x5e
  jmp __alltraps
  1021f2:	e9 97 fc ff ff       	jmp    101e8e <__alltraps>

001021f7 <vector95>:
.globl vector95
vector95:
  pushl $0
  1021f7:	6a 00                	push   $0x0
  pushl $95
  1021f9:	6a 5f                	push   $0x5f
  jmp __alltraps
  1021fb:	e9 8e fc ff ff       	jmp    101e8e <__alltraps>

00102200 <vector96>:
.globl vector96
vector96:
  pushl $0
  102200:	6a 00                	push   $0x0
  pushl $96
  102202:	6a 60                	push   $0x60
  jmp __alltraps
  102204:	e9 85 fc ff ff       	jmp    101e8e <__alltraps>

00102209 <vector97>:
.globl vector97
vector97:
  pushl $0
  102209:	6a 00                	push   $0x0
  pushl $97
  10220b:	6a 61                	push   $0x61
  jmp __alltraps
  10220d:	e9 7c fc ff ff       	jmp    101e8e <__alltraps>

00102212 <vector98>:
.globl vector98
vector98:
  pushl $0
  102212:	6a 00                	push   $0x0
  pushl $98
  102214:	6a 62                	push   $0x62
  jmp __alltraps
  102216:	e9 73 fc ff ff       	jmp    101e8e <__alltraps>

0010221b <vector99>:
.globl vector99
vector99:
  pushl $0
  10221b:	6a 00                	push   $0x0
  pushl $99
  10221d:	6a 63                	push   $0x63
  jmp __alltraps
  10221f:	e9 6a fc ff ff       	jmp    101e8e <__alltraps>

00102224 <vector100>:
.globl vector100
vector100:
  pushl $0
  102224:	6a 00                	push   $0x0
  pushl $100
  102226:	6a 64                	push   $0x64
  jmp __alltraps
  102228:	e9 61 fc ff ff       	jmp    101e8e <__alltraps>

0010222d <vector101>:
.globl vector101
vector101:
  pushl $0
  10222d:	6a 00                	push   $0x0
  pushl $101
  10222f:	6a 65                	push   $0x65
  jmp __alltraps
  102231:	e9 58 fc ff ff       	jmp    101e8e <__alltraps>

00102236 <vector102>:
.globl vector102
vector102:
  pushl $0
  102236:	6a 00                	push   $0x0
  pushl $102
  102238:	6a 66                	push   $0x66
  jmp __alltraps
  10223a:	e9 4f fc ff ff       	jmp    101e8e <__alltraps>

0010223f <vector103>:
.globl vector103
vector103:
  pushl $0
  10223f:	6a 00                	push   $0x0
  pushl $103
  102241:	6a 67                	push   $0x67
  jmp __alltraps
  102243:	e9 46 fc ff ff       	jmp    101e8e <__alltraps>

00102248 <vector104>:
.globl vector104
vector104:
  pushl $0
  102248:	6a 00                	push   $0x0
  pushl $104
  10224a:	6a 68                	push   $0x68
  jmp __alltraps
  10224c:	e9 3d fc ff ff       	jmp    101e8e <__alltraps>

00102251 <vector105>:
.globl vector105
vector105:
  pushl $0
  102251:	6a 00                	push   $0x0
  pushl $105
  102253:	6a 69                	push   $0x69
  jmp __alltraps
  102255:	e9 34 fc ff ff       	jmp    101e8e <__alltraps>

0010225a <vector106>:
.globl vector106
vector106:
  pushl $0
  10225a:	6a 00                	push   $0x0
  pushl $106
  10225c:	6a 6a                	push   $0x6a
  jmp __alltraps
  10225e:	e9 2b fc ff ff       	jmp    101e8e <__alltraps>

00102263 <vector107>:
.globl vector107
vector107:
  pushl $0
  102263:	6a 00                	push   $0x0
  pushl $107
  102265:	6a 6b                	push   $0x6b
  jmp __alltraps
  102267:	e9 22 fc ff ff       	jmp    101e8e <__alltraps>

0010226c <vector108>:
.globl vector108
vector108:
  pushl $0
  10226c:	6a 00                	push   $0x0
  pushl $108
  10226e:	6a 6c                	push   $0x6c
  jmp __alltraps
  102270:	e9 19 fc ff ff       	jmp    101e8e <__alltraps>

00102275 <vector109>:
.globl vector109
vector109:
  pushl $0
  102275:	6a 00                	push   $0x0
  pushl $109
  102277:	6a 6d                	push   $0x6d
  jmp __alltraps
  102279:	e9 10 fc ff ff       	jmp    101e8e <__alltraps>

0010227e <vector110>:
.globl vector110
vector110:
  pushl $0
  10227e:	6a 00                	push   $0x0
  pushl $110
  102280:	6a 6e                	push   $0x6e
  jmp __alltraps
  102282:	e9 07 fc ff ff       	jmp    101e8e <__alltraps>

00102287 <vector111>:
.globl vector111
vector111:
  pushl $0
  102287:	6a 00                	push   $0x0
  pushl $111
  102289:	6a 6f                	push   $0x6f
  jmp __alltraps
  10228b:	e9 fe fb ff ff       	jmp    101e8e <__alltraps>

00102290 <vector112>:
.globl vector112
vector112:
  pushl $0
  102290:	6a 00                	push   $0x0
  pushl $112
  102292:	6a 70                	push   $0x70
  jmp __alltraps
  102294:	e9 f5 fb ff ff       	jmp    101e8e <__alltraps>

00102299 <vector113>:
.globl vector113
vector113:
  pushl $0
  102299:	6a 00                	push   $0x0
  pushl $113
  10229b:	6a 71                	push   $0x71
  jmp __alltraps
  10229d:	e9 ec fb ff ff       	jmp    101e8e <__alltraps>

001022a2 <vector114>:
.globl vector114
vector114:
  pushl $0
  1022a2:	6a 00                	push   $0x0
  pushl $114
  1022a4:	6a 72                	push   $0x72
  jmp __alltraps
  1022a6:	e9 e3 fb ff ff       	jmp    101e8e <__alltraps>

001022ab <vector115>:
.globl vector115
vector115:
  pushl $0
  1022ab:	6a 00                	push   $0x0
  pushl $115
  1022ad:	6a 73                	push   $0x73
  jmp __alltraps
  1022af:	e9 da fb ff ff       	jmp    101e8e <__alltraps>

001022b4 <vector116>:
.globl vector116
vector116:
  pushl $0
  1022b4:	6a 00                	push   $0x0
  pushl $116
  1022b6:	6a 74                	push   $0x74
  jmp __alltraps
  1022b8:	e9 d1 fb ff ff       	jmp    101e8e <__alltraps>

001022bd <vector117>:
.globl vector117
vector117:
  pushl $0
  1022bd:	6a 00                	push   $0x0
  pushl $117
  1022bf:	6a 75                	push   $0x75
  jmp __alltraps
  1022c1:	e9 c8 fb ff ff       	jmp    101e8e <__alltraps>

001022c6 <vector118>:
.globl vector118
vector118:
  pushl $0
  1022c6:	6a 00                	push   $0x0
  pushl $118
  1022c8:	6a 76                	push   $0x76
  jmp __alltraps
  1022ca:	e9 bf fb ff ff       	jmp    101e8e <__alltraps>

001022cf <vector119>:
.globl vector119
vector119:
  pushl $0
  1022cf:	6a 00                	push   $0x0
  pushl $119
  1022d1:	6a 77                	push   $0x77
  jmp __alltraps
  1022d3:	e9 b6 fb ff ff       	jmp    101e8e <__alltraps>

001022d8 <vector120>:
.globl vector120
vector120:
  pushl $0
  1022d8:	6a 00                	push   $0x0
  pushl $120
  1022da:	6a 78                	push   $0x78
  jmp __alltraps
  1022dc:	e9 ad fb ff ff       	jmp    101e8e <__alltraps>

001022e1 <vector121>:
.globl vector121
vector121:
  pushl $0
  1022e1:	6a 00                	push   $0x0
  pushl $121
  1022e3:	6a 79                	push   $0x79
  jmp __alltraps
  1022e5:	e9 a4 fb ff ff       	jmp    101e8e <__alltraps>

001022ea <vector122>:
.globl vector122
vector122:
  pushl $0
  1022ea:	6a 00                	push   $0x0
  pushl $122
  1022ec:	6a 7a                	push   $0x7a
  jmp __alltraps
  1022ee:	e9 9b fb ff ff       	jmp    101e8e <__alltraps>

001022f3 <vector123>:
.globl vector123
vector123:
  pushl $0
  1022f3:	6a 00                	push   $0x0
  pushl $123
  1022f5:	6a 7b                	push   $0x7b
  jmp __alltraps
  1022f7:	e9 92 fb ff ff       	jmp    101e8e <__alltraps>

001022fc <vector124>:
.globl vector124
vector124:
  pushl $0
  1022fc:	6a 00                	push   $0x0
  pushl $124
  1022fe:	6a 7c                	push   $0x7c
  jmp __alltraps
  102300:	e9 89 fb ff ff       	jmp    101e8e <__alltraps>

00102305 <vector125>:
.globl vector125
vector125:
  pushl $0
  102305:	6a 00                	push   $0x0
  pushl $125
  102307:	6a 7d                	push   $0x7d
  jmp __alltraps
  102309:	e9 80 fb ff ff       	jmp    101e8e <__alltraps>

0010230e <vector126>:
.globl vector126
vector126:
  pushl $0
  10230e:	6a 00                	push   $0x0
  pushl $126
  102310:	6a 7e                	push   $0x7e
  jmp __alltraps
  102312:	e9 77 fb ff ff       	jmp    101e8e <__alltraps>

00102317 <vector127>:
.globl vector127
vector127:
  pushl $0
  102317:	6a 00                	push   $0x0
  pushl $127
  102319:	6a 7f                	push   $0x7f
  jmp __alltraps
  10231b:	e9 6e fb ff ff       	jmp    101e8e <__alltraps>

00102320 <vector128>:
.globl vector128
vector128:
  pushl $0
  102320:	6a 00                	push   $0x0
  pushl $128
  102322:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102327:	e9 62 fb ff ff       	jmp    101e8e <__alltraps>

0010232c <vector129>:
.globl vector129
vector129:
  pushl $0
  10232c:	6a 00                	push   $0x0
  pushl $129
  10232e:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102333:	e9 56 fb ff ff       	jmp    101e8e <__alltraps>

00102338 <vector130>:
.globl vector130
vector130:
  pushl $0
  102338:	6a 00                	push   $0x0
  pushl $130
  10233a:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10233f:	e9 4a fb ff ff       	jmp    101e8e <__alltraps>

00102344 <vector131>:
.globl vector131
vector131:
  pushl $0
  102344:	6a 00                	push   $0x0
  pushl $131
  102346:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  10234b:	e9 3e fb ff ff       	jmp    101e8e <__alltraps>

00102350 <vector132>:
.globl vector132
vector132:
  pushl $0
  102350:	6a 00                	push   $0x0
  pushl $132
  102352:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102357:	e9 32 fb ff ff       	jmp    101e8e <__alltraps>

0010235c <vector133>:
.globl vector133
vector133:
  pushl $0
  10235c:	6a 00                	push   $0x0
  pushl $133
  10235e:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102363:	e9 26 fb ff ff       	jmp    101e8e <__alltraps>

00102368 <vector134>:
.globl vector134
vector134:
  pushl $0
  102368:	6a 00                	push   $0x0
  pushl $134
  10236a:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10236f:	e9 1a fb ff ff       	jmp    101e8e <__alltraps>

00102374 <vector135>:
.globl vector135
vector135:
  pushl $0
  102374:	6a 00                	push   $0x0
  pushl $135
  102376:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  10237b:	e9 0e fb ff ff       	jmp    101e8e <__alltraps>

00102380 <vector136>:
.globl vector136
vector136:
  pushl $0
  102380:	6a 00                	push   $0x0
  pushl $136
  102382:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  102387:	e9 02 fb ff ff       	jmp    101e8e <__alltraps>

0010238c <vector137>:
.globl vector137
vector137:
  pushl $0
  10238c:	6a 00                	push   $0x0
  pushl $137
  10238e:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  102393:	e9 f6 fa ff ff       	jmp    101e8e <__alltraps>

00102398 <vector138>:
.globl vector138
vector138:
  pushl $0
  102398:	6a 00                	push   $0x0
  pushl $138
  10239a:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  10239f:	e9 ea fa ff ff       	jmp    101e8e <__alltraps>

001023a4 <vector139>:
.globl vector139
vector139:
  pushl $0
  1023a4:	6a 00                	push   $0x0
  pushl $139
  1023a6:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1023ab:	e9 de fa ff ff       	jmp    101e8e <__alltraps>

001023b0 <vector140>:
.globl vector140
vector140:
  pushl $0
  1023b0:	6a 00                	push   $0x0
  pushl $140
  1023b2:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1023b7:	e9 d2 fa ff ff       	jmp    101e8e <__alltraps>

001023bc <vector141>:
.globl vector141
vector141:
  pushl $0
  1023bc:	6a 00                	push   $0x0
  pushl $141
  1023be:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1023c3:	e9 c6 fa ff ff       	jmp    101e8e <__alltraps>

001023c8 <vector142>:
.globl vector142
vector142:
  pushl $0
  1023c8:	6a 00                	push   $0x0
  pushl $142
  1023ca:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1023cf:	e9 ba fa ff ff       	jmp    101e8e <__alltraps>

001023d4 <vector143>:
.globl vector143
vector143:
  pushl $0
  1023d4:	6a 00                	push   $0x0
  pushl $143
  1023d6:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  1023db:	e9 ae fa ff ff       	jmp    101e8e <__alltraps>

001023e0 <vector144>:
.globl vector144
vector144:
  pushl $0
  1023e0:	6a 00                	push   $0x0
  pushl $144
  1023e2:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  1023e7:	e9 a2 fa ff ff       	jmp    101e8e <__alltraps>

001023ec <vector145>:
.globl vector145
vector145:
  pushl $0
  1023ec:	6a 00                	push   $0x0
  pushl $145
  1023ee:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  1023f3:	e9 96 fa ff ff       	jmp    101e8e <__alltraps>

001023f8 <vector146>:
.globl vector146
vector146:
  pushl $0
  1023f8:	6a 00                	push   $0x0
  pushl $146
  1023fa:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  1023ff:	e9 8a fa ff ff       	jmp    101e8e <__alltraps>

00102404 <vector147>:
.globl vector147
vector147:
  pushl $0
  102404:	6a 00                	push   $0x0
  pushl $147
  102406:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  10240b:	e9 7e fa ff ff       	jmp    101e8e <__alltraps>

00102410 <vector148>:
.globl vector148
vector148:
  pushl $0
  102410:	6a 00                	push   $0x0
  pushl $148
  102412:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102417:	e9 72 fa ff ff       	jmp    101e8e <__alltraps>

0010241c <vector149>:
.globl vector149
vector149:
  pushl $0
  10241c:	6a 00                	push   $0x0
  pushl $149
  10241e:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102423:	e9 66 fa ff ff       	jmp    101e8e <__alltraps>

00102428 <vector150>:
.globl vector150
vector150:
  pushl $0
  102428:	6a 00                	push   $0x0
  pushl $150
  10242a:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10242f:	e9 5a fa ff ff       	jmp    101e8e <__alltraps>

00102434 <vector151>:
.globl vector151
vector151:
  pushl $0
  102434:	6a 00                	push   $0x0
  pushl $151
  102436:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  10243b:	e9 4e fa ff ff       	jmp    101e8e <__alltraps>

00102440 <vector152>:
.globl vector152
vector152:
  pushl $0
  102440:	6a 00                	push   $0x0
  pushl $152
  102442:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102447:	e9 42 fa ff ff       	jmp    101e8e <__alltraps>

0010244c <vector153>:
.globl vector153
vector153:
  pushl $0
  10244c:	6a 00                	push   $0x0
  pushl $153
  10244e:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102453:	e9 36 fa ff ff       	jmp    101e8e <__alltraps>

00102458 <vector154>:
.globl vector154
vector154:
  pushl $0
  102458:	6a 00                	push   $0x0
  pushl $154
  10245a:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  10245f:	e9 2a fa ff ff       	jmp    101e8e <__alltraps>

00102464 <vector155>:
.globl vector155
vector155:
  pushl $0
  102464:	6a 00                	push   $0x0
  pushl $155
  102466:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  10246b:	e9 1e fa ff ff       	jmp    101e8e <__alltraps>

00102470 <vector156>:
.globl vector156
vector156:
  pushl $0
  102470:	6a 00                	push   $0x0
  pushl $156
  102472:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  102477:	e9 12 fa ff ff       	jmp    101e8e <__alltraps>

0010247c <vector157>:
.globl vector157
vector157:
  pushl $0
  10247c:	6a 00                	push   $0x0
  pushl $157
  10247e:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  102483:	e9 06 fa ff ff       	jmp    101e8e <__alltraps>

00102488 <vector158>:
.globl vector158
vector158:
  pushl $0
  102488:	6a 00                	push   $0x0
  pushl $158
  10248a:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  10248f:	e9 fa f9 ff ff       	jmp    101e8e <__alltraps>

00102494 <vector159>:
.globl vector159
vector159:
  pushl $0
  102494:	6a 00                	push   $0x0
  pushl $159
  102496:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  10249b:	e9 ee f9 ff ff       	jmp    101e8e <__alltraps>

001024a0 <vector160>:
.globl vector160
vector160:
  pushl $0
  1024a0:	6a 00                	push   $0x0
  pushl $160
  1024a2:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1024a7:	e9 e2 f9 ff ff       	jmp    101e8e <__alltraps>

001024ac <vector161>:
.globl vector161
vector161:
  pushl $0
  1024ac:	6a 00                	push   $0x0
  pushl $161
  1024ae:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1024b3:	e9 d6 f9 ff ff       	jmp    101e8e <__alltraps>

001024b8 <vector162>:
.globl vector162
vector162:
  pushl $0
  1024b8:	6a 00                	push   $0x0
  pushl $162
  1024ba:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1024bf:	e9 ca f9 ff ff       	jmp    101e8e <__alltraps>

001024c4 <vector163>:
.globl vector163
vector163:
  pushl $0
  1024c4:	6a 00                	push   $0x0
  pushl $163
  1024c6:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1024cb:	e9 be f9 ff ff       	jmp    101e8e <__alltraps>

001024d0 <vector164>:
.globl vector164
vector164:
  pushl $0
  1024d0:	6a 00                	push   $0x0
  pushl $164
  1024d2:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  1024d7:	e9 b2 f9 ff ff       	jmp    101e8e <__alltraps>

001024dc <vector165>:
.globl vector165
vector165:
  pushl $0
  1024dc:	6a 00                	push   $0x0
  pushl $165
  1024de:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  1024e3:	e9 a6 f9 ff ff       	jmp    101e8e <__alltraps>

001024e8 <vector166>:
.globl vector166
vector166:
  pushl $0
  1024e8:	6a 00                	push   $0x0
  pushl $166
  1024ea:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  1024ef:	e9 9a f9 ff ff       	jmp    101e8e <__alltraps>

001024f4 <vector167>:
.globl vector167
vector167:
  pushl $0
  1024f4:	6a 00                	push   $0x0
  pushl $167
  1024f6:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  1024fb:	e9 8e f9 ff ff       	jmp    101e8e <__alltraps>

00102500 <vector168>:
.globl vector168
vector168:
  pushl $0
  102500:	6a 00                	push   $0x0
  pushl $168
  102502:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  102507:	e9 82 f9 ff ff       	jmp    101e8e <__alltraps>

0010250c <vector169>:
.globl vector169
vector169:
  pushl $0
  10250c:	6a 00                	push   $0x0
  pushl $169
  10250e:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102513:	e9 76 f9 ff ff       	jmp    101e8e <__alltraps>

00102518 <vector170>:
.globl vector170
vector170:
  pushl $0
  102518:	6a 00                	push   $0x0
  pushl $170
  10251a:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  10251f:	e9 6a f9 ff ff       	jmp    101e8e <__alltraps>

00102524 <vector171>:
.globl vector171
vector171:
  pushl $0
  102524:	6a 00                	push   $0x0
  pushl $171
  102526:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  10252b:	e9 5e f9 ff ff       	jmp    101e8e <__alltraps>

00102530 <vector172>:
.globl vector172
vector172:
  pushl $0
  102530:	6a 00                	push   $0x0
  pushl $172
  102532:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102537:	e9 52 f9 ff ff       	jmp    101e8e <__alltraps>

0010253c <vector173>:
.globl vector173
vector173:
  pushl $0
  10253c:	6a 00                	push   $0x0
  pushl $173
  10253e:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102543:	e9 46 f9 ff ff       	jmp    101e8e <__alltraps>

00102548 <vector174>:
.globl vector174
vector174:
  pushl $0
  102548:	6a 00                	push   $0x0
  pushl $174
  10254a:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  10254f:	e9 3a f9 ff ff       	jmp    101e8e <__alltraps>

00102554 <vector175>:
.globl vector175
vector175:
  pushl $0
  102554:	6a 00                	push   $0x0
  pushl $175
  102556:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  10255b:	e9 2e f9 ff ff       	jmp    101e8e <__alltraps>

00102560 <vector176>:
.globl vector176
vector176:
  pushl $0
  102560:	6a 00                	push   $0x0
  pushl $176
  102562:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102567:	e9 22 f9 ff ff       	jmp    101e8e <__alltraps>

0010256c <vector177>:
.globl vector177
vector177:
  pushl $0
  10256c:	6a 00                	push   $0x0
  pushl $177
  10256e:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  102573:	e9 16 f9 ff ff       	jmp    101e8e <__alltraps>

00102578 <vector178>:
.globl vector178
vector178:
  pushl $0
  102578:	6a 00                	push   $0x0
  pushl $178
  10257a:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  10257f:	e9 0a f9 ff ff       	jmp    101e8e <__alltraps>

00102584 <vector179>:
.globl vector179
vector179:
  pushl $0
  102584:	6a 00                	push   $0x0
  pushl $179
  102586:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  10258b:	e9 fe f8 ff ff       	jmp    101e8e <__alltraps>

00102590 <vector180>:
.globl vector180
vector180:
  pushl $0
  102590:	6a 00                	push   $0x0
  pushl $180
  102592:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  102597:	e9 f2 f8 ff ff       	jmp    101e8e <__alltraps>

0010259c <vector181>:
.globl vector181
vector181:
  pushl $0
  10259c:	6a 00                	push   $0x0
  pushl $181
  10259e:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1025a3:	e9 e6 f8 ff ff       	jmp    101e8e <__alltraps>

001025a8 <vector182>:
.globl vector182
vector182:
  pushl $0
  1025a8:	6a 00                	push   $0x0
  pushl $182
  1025aa:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1025af:	e9 da f8 ff ff       	jmp    101e8e <__alltraps>

001025b4 <vector183>:
.globl vector183
vector183:
  pushl $0
  1025b4:	6a 00                	push   $0x0
  pushl $183
  1025b6:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1025bb:	e9 ce f8 ff ff       	jmp    101e8e <__alltraps>

001025c0 <vector184>:
.globl vector184
vector184:
  pushl $0
  1025c0:	6a 00                	push   $0x0
  pushl $184
  1025c2:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1025c7:	e9 c2 f8 ff ff       	jmp    101e8e <__alltraps>

001025cc <vector185>:
.globl vector185
vector185:
  pushl $0
  1025cc:	6a 00                	push   $0x0
  pushl $185
  1025ce:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  1025d3:	e9 b6 f8 ff ff       	jmp    101e8e <__alltraps>

001025d8 <vector186>:
.globl vector186
vector186:
  pushl $0
  1025d8:	6a 00                	push   $0x0
  pushl $186
  1025da:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  1025df:	e9 aa f8 ff ff       	jmp    101e8e <__alltraps>

001025e4 <vector187>:
.globl vector187
vector187:
  pushl $0
  1025e4:	6a 00                	push   $0x0
  pushl $187
  1025e6:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  1025eb:	e9 9e f8 ff ff       	jmp    101e8e <__alltraps>

001025f0 <vector188>:
.globl vector188
vector188:
  pushl $0
  1025f0:	6a 00                	push   $0x0
  pushl $188
  1025f2:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  1025f7:	e9 92 f8 ff ff       	jmp    101e8e <__alltraps>

001025fc <vector189>:
.globl vector189
vector189:
  pushl $0
  1025fc:	6a 00                	push   $0x0
  pushl $189
  1025fe:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102603:	e9 86 f8 ff ff       	jmp    101e8e <__alltraps>

00102608 <vector190>:
.globl vector190
vector190:
  pushl $0
  102608:	6a 00                	push   $0x0
  pushl $190
  10260a:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  10260f:	e9 7a f8 ff ff       	jmp    101e8e <__alltraps>

00102614 <vector191>:
.globl vector191
vector191:
  pushl $0
  102614:	6a 00                	push   $0x0
  pushl $191
  102616:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  10261b:	e9 6e f8 ff ff       	jmp    101e8e <__alltraps>

00102620 <vector192>:
.globl vector192
vector192:
  pushl $0
  102620:	6a 00                	push   $0x0
  pushl $192
  102622:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102627:	e9 62 f8 ff ff       	jmp    101e8e <__alltraps>

0010262c <vector193>:
.globl vector193
vector193:
  pushl $0
  10262c:	6a 00                	push   $0x0
  pushl $193
  10262e:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102633:	e9 56 f8 ff ff       	jmp    101e8e <__alltraps>

00102638 <vector194>:
.globl vector194
vector194:
  pushl $0
  102638:	6a 00                	push   $0x0
  pushl $194
  10263a:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10263f:	e9 4a f8 ff ff       	jmp    101e8e <__alltraps>

00102644 <vector195>:
.globl vector195
vector195:
  pushl $0
  102644:	6a 00                	push   $0x0
  pushl $195
  102646:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  10264b:	e9 3e f8 ff ff       	jmp    101e8e <__alltraps>

00102650 <vector196>:
.globl vector196
vector196:
  pushl $0
  102650:	6a 00                	push   $0x0
  pushl $196
  102652:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102657:	e9 32 f8 ff ff       	jmp    101e8e <__alltraps>

0010265c <vector197>:
.globl vector197
vector197:
  pushl $0
  10265c:	6a 00                	push   $0x0
  pushl $197
  10265e:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102663:	e9 26 f8 ff ff       	jmp    101e8e <__alltraps>

00102668 <vector198>:
.globl vector198
vector198:
  pushl $0
  102668:	6a 00                	push   $0x0
  pushl $198
  10266a:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10266f:	e9 1a f8 ff ff       	jmp    101e8e <__alltraps>

00102674 <vector199>:
.globl vector199
vector199:
  pushl $0
  102674:	6a 00                	push   $0x0
  pushl $199
  102676:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  10267b:	e9 0e f8 ff ff       	jmp    101e8e <__alltraps>

00102680 <vector200>:
.globl vector200
vector200:
  pushl $0
  102680:	6a 00                	push   $0x0
  pushl $200
  102682:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  102687:	e9 02 f8 ff ff       	jmp    101e8e <__alltraps>

0010268c <vector201>:
.globl vector201
vector201:
  pushl $0
  10268c:	6a 00                	push   $0x0
  pushl $201
  10268e:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  102693:	e9 f6 f7 ff ff       	jmp    101e8e <__alltraps>

00102698 <vector202>:
.globl vector202
vector202:
  pushl $0
  102698:	6a 00                	push   $0x0
  pushl $202
  10269a:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  10269f:	e9 ea f7 ff ff       	jmp    101e8e <__alltraps>

001026a4 <vector203>:
.globl vector203
vector203:
  pushl $0
  1026a4:	6a 00                	push   $0x0
  pushl $203
  1026a6:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1026ab:	e9 de f7 ff ff       	jmp    101e8e <__alltraps>

001026b0 <vector204>:
.globl vector204
vector204:
  pushl $0
  1026b0:	6a 00                	push   $0x0
  pushl $204
  1026b2:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1026b7:	e9 d2 f7 ff ff       	jmp    101e8e <__alltraps>

001026bc <vector205>:
.globl vector205
vector205:
  pushl $0
  1026bc:	6a 00                	push   $0x0
  pushl $205
  1026be:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1026c3:	e9 c6 f7 ff ff       	jmp    101e8e <__alltraps>

001026c8 <vector206>:
.globl vector206
vector206:
  pushl $0
  1026c8:	6a 00                	push   $0x0
  pushl $206
  1026ca:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1026cf:	e9 ba f7 ff ff       	jmp    101e8e <__alltraps>

001026d4 <vector207>:
.globl vector207
vector207:
  pushl $0
  1026d4:	6a 00                	push   $0x0
  pushl $207
  1026d6:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  1026db:	e9 ae f7 ff ff       	jmp    101e8e <__alltraps>

001026e0 <vector208>:
.globl vector208
vector208:
  pushl $0
  1026e0:	6a 00                	push   $0x0
  pushl $208
  1026e2:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  1026e7:	e9 a2 f7 ff ff       	jmp    101e8e <__alltraps>

001026ec <vector209>:
.globl vector209
vector209:
  pushl $0
  1026ec:	6a 00                	push   $0x0
  pushl $209
  1026ee:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  1026f3:	e9 96 f7 ff ff       	jmp    101e8e <__alltraps>

001026f8 <vector210>:
.globl vector210
vector210:
  pushl $0
  1026f8:	6a 00                	push   $0x0
  pushl $210
  1026fa:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  1026ff:	e9 8a f7 ff ff       	jmp    101e8e <__alltraps>

00102704 <vector211>:
.globl vector211
vector211:
  pushl $0
  102704:	6a 00                	push   $0x0
  pushl $211
  102706:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  10270b:	e9 7e f7 ff ff       	jmp    101e8e <__alltraps>

00102710 <vector212>:
.globl vector212
vector212:
  pushl $0
  102710:	6a 00                	push   $0x0
  pushl $212
  102712:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102717:	e9 72 f7 ff ff       	jmp    101e8e <__alltraps>

0010271c <vector213>:
.globl vector213
vector213:
  pushl $0
  10271c:	6a 00                	push   $0x0
  pushl $213
  10271e:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102723:	e9 66 f7 ff ff       	jmp    101e8e <__alltraps>

00102728 <vector214>:
.globl vector214
vector214:
  pushl $0
  102728:	6a 00                	push   $0x0
  pushl $214
  10272a:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10272f:	e9 5a f7 ff ff       	jmp    101e8e <__alltraps>

00102734 <vector215>:
.globl vector215
vector215:
  pushl $0
  102734:	6a 00                	push   $0x0
  pushl $215
  102736:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  10273b:	e9 4e f7 ff ff       	jmp    101e8e <__alltraps>

00102740 <vector216>:
.globl vector216
vector216:
  pushl $0
  102740:	6a 00                	push   $0x0
  pushl $216
  102742:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102747:	e9 42 f7 ff ff       	jmp    101e8e <__alltraps>

0010274c <vector217>:
.globl vector217
vector217:
  pushl $0
  10274c:	6a 00                	push   $0x0
  pushl $217
  10274e:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102753:	e9 36 f7 ff ff       	jmp    101e8e <__alltraps>

00102758 <vector218>:
.globl vector218
vector218:
  pushl $0
  102758:	6a 00                	push   $0x0
  pushl $218
  10275a:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  10275f:	e9 2a f7 ff ff       	jmp    101e8e <__alltraps>

00102764 <vector219>:
.globl vector219
vector219:
  pushl $0
  102764:	6a 00                	push   $0x0
  pushl $219
  102766:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  10276b:	e9 1e f7 ff ff       	jmp    101e8e <__alltraps>

00102770 <vector220>:
.globl vector220
vector220:
  pushl $0
  102770:	6a 00                	push   $0x0
  pushl $220
  102772:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  102777:	e9 12 f7 ff ff       	jmp    101e8e <__alltraps>

0010277c <vector221>:
.globl vector221
vector221:
  pushl $0
  10277c:	6a 00                	push   $0x0
  pushl $221
  10277e:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  102783:	e9 06 f7 ff ff       	jmp    101e8e <__alltraps>

00102788 <vector222>:
.globl vector222
vector222:
  pushl $0
  102788:	6a 00                	push   $0x0
  pushl $222
  10278a:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  10278f:	e9 fa f6 ff ff       	jmp    101e8e <__alltraps>

00102794 <vector223>:
.globl vector223
vector223:
  pushl $0
  102794:	6a 00                	push   $0x0
  pushl $223
  102796:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  10279b:	e9 ee f6 ff ff       	jmp    101e8e <__alltraps>

001027a0 <vector224>:
.globl vector224
vector224:
  pushl $0
  1027a0:	6a 00                	push   $0x0
  pushl $224
  1027a2:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1027a7:	e9 e2 f6 ff ff       	jmp    101e8e <__alltraps>

001027ac <vector225>:
.globl vector225
vector225:
  pushl $0
  1027ac:	6a 00                	push   $0x0
  pushl $225
  1027ae:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1027b3:	e9 d6 f6 ff ff       	jmp    101e8e <__alltraps>

001027b8 <vector226>:
.globl vector226
vector226:
  pushl $0
  1027b8:	6a 00                	push   $0x0
  pushl $226
  1027ba:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  1027bf:	e9 ca f6 ff ff       	jmp    101e8e <__alltraps>

001027c4 <vector227>:
.globl vector227
vector227:
  pushl $0
  1027c4:	6a 00                	push   $0x0
  pushl $227
  1027c6:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1027cb:	e9 be f6 ff ff       	jmp    101e8e <__alltraps>

001027d0 <vector228>:
.globl vector228
vector228:
  pushl $0
  1027d0:	6a 00                	push   $0x0
  pushl $228
  1027d2:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  1027d7:	e9 b2 f6 ff ff       	jmp    101e8e <__alltraps>

001027dc <vector229>:
.globl vector229
vector229:
  pushl $0
  1027dc:	6a 00                	push   $0x0
  pushl $229
  1027de:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  1027e3:	e9 a6 f6 ff ff       	jmp    101e8e <__alltraps>

001027e8 <vector230>:
.globl vector230
vector230:
  pushl $0
  1027e8:	6a 00                	push   $0x0
  pushl $230
  1027ea:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  1027ef:	e9 9a f6 ff ff       	jmp    101e8e <__alltraps>

001027f4 <vector231>:
.globl vector231
vector231:
  pushl $0
  1027f4:	6a 00                	push   $0x0
  pushl $231
  1027f6:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  1027fb:	e9 8e f6 ff ff       	jmp    101e8e <__alltraps>

00102800 <vector232>:
.globl vector232
vector232:
  pushl $0
  102800:	6a 00                	push   $0x0
  pushl $232
  102802:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102807:	e9 82 f6 ff ff       	jmp    101e8e <__alltraps>

0010280c <vector233>:
.globl vector233
vector233:
  pushl $0
  10280c:	6a 00                	push   $0x0
  pushl $233
  10280e:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102813:	e9 76 f6 ff ff       	jmp    101e8e <__alltraps>

00102818 <vector234>:
.globl vector234
vector234:
  pushl $0
  102818:	6a 00                	push   $0x0
  pushl $234
  10281a:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  10281f:	e9 6a f6 ff ff       	jmp    101e8e <__alltraps>

00102824 <vector235>:
.globl vector235
vector235:
  pushl $0
  102824:	6a 00                	push   $0x0
  pushl $235
  102826:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  10282b:	e9 5e f6 ff ff       	jmp    101e8e <__alltraps>

00102830 <vector236>:
.globl vector236
vector236:
  pushl $0
  102830:	6a 00                	push   $0x0
  pushl $236
  102832:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102837:	e9 52 f6 ff ff       	jmp    101e8e <__alltraps>

0010283c <vector237>:
.globl vector237
vector237:
  pushl $0
  10283c:	6a 00                	push   $0x0
  pushl $237
  10283e:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102843:	e9 46 f6 ff ff       	jmp    101e8e <__alltraps>

00102848 <vector238>:
.globl vector238
vector238:
  pushl $0
  102848:	6a 00                	push   $0x0
  pushl $238
  10284a:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  10284f:	e9 3a f6 ff ff       	jmp    101e8e <__alltraps>

00102854 <vector239>:
.globl vector239
vector239:
  pushl $0
  102854:	6a 00                	push   $0x0
  pushl $239
  102856:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  10285b:	e9 2e f6 ff ff       	jmp    101e8e <__alltraps>

00102860 <vector240>:
.globl vector240
vector240:
  pushl $0
  102860:	6a 00                	push   $0x0
  pushl $240
  102862:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102867:	e9 22 f6 ff ff       	jmp    101e8e <__alltraps>

0010286c <vector241>:
.globl vector241
vector241:
  pushl $0
  10286c:	6a 00                	push   $0x0
  pushl $241
  10286e:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  102873:	e9 16 f6 ff ff       	jmp    101e8e <__alltraps>

00102878 <vector242>:
.globl vector242
vector242:
  pushl $0
  102878:	6a 00                	push   $0x0
  pushl $242
  10287a:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  10287f:	e9 0a f6 ff ff       	jmp    101e8e <__alltraps>

00102884 <vector243>:
.globl vector243
vector243:
  pushl $0
  102884:	6a 00                	push   $0x0
  pushl $243
  102886:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  10288b:	e9 fe f5 ff ff       	jmp    101e8e <__alltraps>

00102890 <vector244>:
.globl vector244
vector244:
  pushl $0
  102890:	6a 00                	push   $0x0
  pushl $244
  102892:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  102897:	e9 f2 f5 ff ff       	jmp    101e8e <__alltraps>

0010289c <vector245>:
.globl vector245
vector245:
  pushl $0
  10289c:	6a 00                	push   $0x0
  pushl $245
  10289e:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1028a3:	e9 e6 f5 ff ff       	jmp    101e8e <__alltraps>

001028a8 <vector246>:
.globl vector246
vector246:
  pushl $0
  1028a8:	6a 00                	push   $0x0
  pushl $246
  1028aa:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1028af:	e9 da f5 ff ff       	jmp    101e8e <__alltraps>

001028b4 <vector247>:
.globl vector247
vector247:
  pushl $0
  1028b4:	6a 00                	push   $0x0
  pushl $247
  1028b6:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  1028bb:	e9 ce f5 ff ff       	jmp    101e8e <__alltraps>

001028c0 <vector248>:
.globl vector248
vector248:
  pushl $0
  1028c0:	6a 00                	push   $0x0
  pushl $248
  1028c2:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1028c7:	e9 c2 f5 ff ff       	jmp    101e8e <__alltraps>

001028cc <vector249>:
.globl vector249
vector249:
  pushl $0
  1028cc:	6a 00                	push   $0x0
  pushl $249
  1028ce:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  1028d3:	e9 b6 f5 ff ff       	jmp    101e8e <__alltraps>

001028d8 <vector250>:
.globl vector250
vector250:
  pushl $0
  1028d8:	6a 00                	push   $0x0
  pushl $250
  1028da:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  1028df:	e9 aa f5 ff ff       	jmp    101e8e <__alltraps>

001028e4 <vector251>:
.globl vector251
vector251:
  pushl $0
  1028e4:	6a 00                	push   $0x0
  pushl $251
  1028e6:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  1028eb:	e9 9e f5 ff ff       	jmp    101e8e <__alltraps>

001028f0 <vector252>:
.globl vector252
vector252:
  pushl $0
  1028f0:	6a 00                	push   $0x0
  pushl $252
  1028f2:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  1028f7:	e9 92 f5 ff ff       	jmp    101e8e <__alltraps>

001028fc <vector253>:
.globl vector253
vector253:
  pushl $0
  1028fc:	6a 00                	push   $0x0
  pushl $253
  1028fe:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102903:	e9 86 f5 ff ff       	jmp    101e8e <__alltraps>

00102908 <vector254>:
.globl vector254
vector254:
  pushl $0
  102908:	6a 00                	push   $0x0
  pushl $254
  10290a:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  10290f:	e9 7a f5 ff ff       	jmp    101e8e <__alltraps>

00102914 <vector255>:
.globl vector255
vector255:
  pushl $0
  102914:	6a 00                	push   $0x0
  pushl $255
  102916:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  10291b:	e9 6e f5 ff ff       	jmp    101e8e <__alltraps>

00102920 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102920:	55                   	push   %ebp
  102921:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102923:	8b 45 08             	mov    0x8(%ebp),%eax
  102926:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102929:	b8 23 00 00 00       	mov    $0x23,%eax
  10292e:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102930:	b8 23 00 00 00       	mov    $0x23,%eax
  102935:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102937:	b8 10 00 00 00       	mov    $0x10,%eax
  10293c:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  10293e:	b8 10 00 00 00       	mov    $0x10,%eax
  102943:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102945:	b8 10 00 00 00       	mov    $0x10,%eax
  10294a:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  10294c:	ea 53 29 10 00 08 00 	ljmp   $0x8,$0x102953
}
  102953:	5d                   	pop    %ebp
  102954:	c3                   	ret    

00102955 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102955:	55                   	push   %ebp
  102956:	89 e5                	mov    %esp,%ebp
  102958:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  10295b:	b8 80 f9 10 00       	mov    $0x10f980,%eax
  102960:	05 00 04 00 00       	add    $0x400,%eax
  102965:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  10296a:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  102971:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  102973:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  10297a:	68 00 
  10297c:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102981:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  102987:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  10298c:	c1 e8 10             	shr    $0x10,%eax
  10298f:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  102994:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10299b:	83 e0 f0             	and    $0xfffffff0,%eax
  10299e:	83 c8 09             	or     $0x9,%eax
  1029a1:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1029a6:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1029ad:	83 c8 10             	or     $0x10,%eax
  1029b0:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1029b5:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1029bc:	83 e0 9f             	and    $0xffffff9f,%eax
  1029bf:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1029c4:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1029cb:	83 c8 80             	or     $0xffffff80,%eax
  1029ce:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1029d3:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1029da:	83 e0 f0             	and    $0xfffffff0,%eax
  1029dd:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1029e2:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1029e9:	83 e0 ef             	and    $0xffffffef,%eax
  1029ec:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  1029f1:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  1029f8:	83 e0 df             	and    $0xffffffdf,%eax
  1029fb:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a00:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a07:	83 c8 40             	or     $0x40,%eax
  102a0a:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a0f:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102a16:	83 e0 7f             	and    $0x7f,%eax
  102a19:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102a1e:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102a23:	c1 e8 18             	shr    $0x18,%eax
  102a26:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  102a2b:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102a32:	83 e0 ef             	and    $0xffffffef,%eax
  102a35:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  102a3a:	c7 04 24 10 ea 10 00 	movl   $0x10ea10,(%esp)
  102a41:	e8 da fe ff ff       	call   102920 <lgdt>
  102a46:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("cli");
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  102a4c:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102a50:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102a53:	c9                   	leave  
  102a54:	c3                   	ret    

00102a55 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102a55:	55                   	push   %ebp
  102a56:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102a58:	e8 f8 fe ff ff       	call   102955 <gdt_init>
}
  102a5d:	5d                   	pop    %ebp
  102a5e:	c3                   	ret    

00102a5f <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102a5f:	55                   	push   %ebp
  102a60:	89 e5                	mov    %esp,%ebp
  102a62:	83 ec 58             	sub    $0x58,%esp
  102a65:	8b 45 10             	mov    0x10(%ebp),%eax
  102a68:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102a6b:	8b 45 14             	mov    0x14(%ebp),%eax
  102a6e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102a71:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102a74:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102a77:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102a7a:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102a7d:	8b 45 18             	mov    0x18(%ebp),%eax
  102a80:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102a83:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102a86:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102a89:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102a8c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102a8f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a92:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102a95:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102a99:	74 1c                	je     102ab7 <printnum+0x58>
  102a9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102a9e:	ba 00 00 00 00       	mov    $0x0,%edx
  102aa3:	f7 75 e4             	divl   -0x1c(%ebp)
  102aa6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102aa9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102aac:	ba 00 00 00 00       	mov    $0x0,%edx
  102ab1:	f7 75 e4             	divl   -0x1c(%ebp)
  102ab4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ab7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102aba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102abd:	f7 75 e4             	divl   -0x1c(%ebp)
  102ac0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102ac3:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102ac6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ac9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102acc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102acf:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102ad2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102ad5:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102ad8:	8b 45 18             	mov    0x18(%ebp),%eax
  102adb:	ba 00 00 00 00       	mov    $0x0,%edx
  102ae0:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102ae3:	77 56                	ja     102b3b <printnum+0xdc>
  102ae5:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102ae8:	72 05                	jb     102aef <printnum+0x90>
  102aea:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  102aed:	77 4c                	ja     102b3b <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
  102aef:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102af2:	8d 50 ff             	lea    -0x1(%eax),%edx
  102af5:	8b 45 20             	mov    0x20(%ebp),%eax
  102af8:	89 44 24 18          	mov    %eax,0x18(%esp)
  102afc:	89 54 24 14          	mov    %edx,0x14(%esp)
  102b00:	8b 45 18             	mov    0x18(%ebp),%eax
  102b03:	89 44 24 10          	mov    %eax,0x10(%esp)
  102b07:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102b0a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102b0d:	89 44 24 08          	mov    %eax,0x8(%esp)
  102b11:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102b15:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b18:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  102b1f:	89 04 24             	mov    %eax,(%esp)
  102b22:	e8 38 ff ff ff       	call   102a5f <printnum>
  102b27:	eb 1c                	jmp    102b45 <printnum+0xe6>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102b29:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b2c:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b30:	8b 45 20             	mov    0x20(%ebp),%eax
  102b33:	89 04 24             	mov    %eax,(%esp)
  102b36:	8b 45 08             	mov    0x8(%ebp),%eax
  102b39:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  102b3b:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  102b3f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102b43:	7f e4                	jg     102b29 <printnum+0xca>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102b45:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102b48:	05 50 3d 10 00       	add    $0x103d50,%eax
  102b4d:	0f b6 00             	movzbl (%eax),%eax
  102b50:	0f be c0             	movsbl %al,%eax
  102b53:	8b 55 0c             	mov    0xc(%ebp),%edx
  102b56:	89 54 24 04          	mov    %edx,0x4(%esp)
  102b5a:	89 04 24             	mov    %eax,(%esp)
  102b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  102b60:	ff d0                	call   *%eax
}
  102b62:	c9                   	leave  
  102b63:	c3                   	ret    

00102b64 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102b64:	55                   	push   %ebp
  102b65:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102b67:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102b6b:	7e 14                	jle    102b81 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  102b70:	8b 00                	mov    (%eax),%eax
  102b72:	8d 48 08             	lea    0x8(%eax),%ecx
  102b75:	8b 55 08             	mov    0x8(%ebp),%edx
  102b78:	89 0a                	mov    %ecx,(%edx)
  102b7a:	8b 50 04             	mov    0x4(%eax),%edx
  102b7d:	8b 00                	mov    (%eax),%eax
  102b7f:	eb 30                	jmp    102bb1 <getuint+0x4d>
    }
    else if (lflag) {
  102b81:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102b85:	74 16                	je     102b9d <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102b87:	8b 45 08             	mov    0x8(%ebp),%eax
  102b8a:	8b 00                	mov    (%eax),%eax
  102b8c:	8d 48 04             	lea    0x4(%eax),%ecx
  102b8f:	8b 55 08             	mov    0x8(%ebp),%edx
  102b92:	89 0a                	mov    %ecx,(%edx)
  102b94:	8b 00                	mov    (%eax),%eax
  102b96:	ba 00 00 00 00       	mov    $0x0,%edx
  102b9b:	eb 14                	jmp    102bb1 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102b9d:	8b 45 08             	mov    0x8(%ebp),%eax
  102ba0:	8b 00                	mov    (%eax),%eax
  102ba2:	8d 48 04             	lea    0x4(%eax),%ecx
  102ba5:	8b 55 08             	mov    0x8(%ebp),%edx
  102ba8:	89 0a                	mov    %ecx,(%edx)
  102baa:	8b 00                	mov    (%eax),%eax
  102bac:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102bb1:	5d                   	pop    %ebp
  102bb2:	c3                   	ret    

00102bb3 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102bb3:	55                   	push   %ebp
  102bb4:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102bb6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102bba:	7e 14                	jle    102bd0 <getint+0x1d>
        return va_arg(*ap, long long);
  102bbc:	8b 45 08             	mov    0x8(%ebp),%eax
  102bbf:	8b 00                	mov    (%eax),%eax
  102bc1:	8d 48 08             	lea    0x8(%eax),%ecx
  102bc4:	8b 55 08             	mov    0x8(%ebp),%edx
  102bc7:	89 0a                	mov    %ecx,(%edx)
  102bc9:	8b 50 04             	mov    0x4(%eax),%edx
  102bcc:	8b 00                	mov    (%eax),%eax
  102bce:	eb 28                	jmp    102bf8 <getint+0x45>
    }
    else if (lflag) {
  102bd0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102bd4:	74 12                	je     102be8 <getint+0x35>
        return va_arg(*ap, long);
  102bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  102bd9:	8b 00                	mov    (%eax),%eax
  102bdb:	8d 48 04             	lea    0x4(%eax),%ecx
  102bde:	8b 55 08             	mov    0x8(%ebp),%edx
  102be1:	89 0a                	mov    %ecx,(%edx)
  102be3:	8b 00                	mov    (%eax),%eax
  102be5:	99                   	cltd   
  102be6:	eb 10                	jmp    102bf8 <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102be8:	8b 45 08             	mov    0x8(%ebp),%eax
  102beb:	8b 00                	mov    (%eax),%eax
  102bed:	8d 48 04             	lea    0x4(%eax),%ecx
  102bf0:	8b 55 08             	mov    0x8(%ebp),%edx
  102bf3:	89 0a                	mov    %ecx,(%edx)
  102bf5:	8b 00                	mov    (%eax),%eax
  102bf7:	99                   	cltd   
    }
}
  102bf8:	5d                   	pop    %ebp
  102bf9:	c3                   	ret    

00102bfa <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  102bfa:	55                   	push   %ebp
  102bfb:	89 e5                	mov    %esp,%ebp
  102bfd:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  102c00:	8d 45 14             	lea    0x14(%ebp),%eax
  102c03:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  102c06:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102c09:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102c0d:	8b 45 10             	mov    0x10(%ebp),%eax
  102c10:	89 44 24 08          	mov    %eax,0x8(%esp)
  102c14:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c17:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c1b:	8b 45 08             	mov    0x8(%ebp),%eax
  102c1e:	89 04 24             	mov    %eax,(%esp)
  102c21:	e8 02 00 00 00       	call   102c28 <vprintfmt>
    va_end(ap);
}
  102c26:	c9                   	leave  
  102c27:	c3                   	ret    

00102c28 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102c28:	55                   	push   %ebp
  102c29:	89 e5                	mov    %esp,%ebp
  102c2b:	56                   	push   %esi
  102c2c:	53                   	push   %ebx
  102c2d:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102c30:	eb 18                	jmp    102c4a <vprintfmt+0x22>
            if (ch == '\0') {
  102c32:	85 db                	test   %ebx,%ebx
  102c34:	75 05                	jne    102c3b <vprintfmt+0x13>
                return;
  102c36:	e9 d1 03 00 00       	jmp    10300c <vprintfmt+0x3e4>
            }
            putch(ch, putdat);
  102c3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102c3e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102c42:	89 1c 24             	mov    %ebx,(%esp)
  102c45:	8b 45 08             	mov    0x8(%ebp),%eax
  102c48:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102c4a:	8b 45 10             	mov    0x10(%ebp),%eax
  102c4d:	8d 50 01             	lea    0x1(%eax),%edx
  102c50:	89 55 10             	mov    %edx,0x10(%ebp)
  102c53:	0f b6 00             	movzbl (%eax),%eax
  102c56:	0f b6 d8             	movzbl %al,%ebx
  102c59:	83 fb 25             	cmp    $0x25,%ebx
  102c5c:	75 d4                	jne    102c32 <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  102c5e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102c62:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102c69:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102c6c:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102c6f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102c76:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102c79:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102c7c:	8b 45 10             	mov    0x10(%ebp),%eax
  102c7f:	8d 50 01             	lea    0x1(%eax),%edx
  102c82:	89 55 10             	mov    %edx,0x10(%ebp)
  102c85:	0f b6 00             	movzbl (%eax),%eax
  102c88:	0f b6 d8             	movzbl %al,%ebx
  102c8b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102c8e:	83 f8 55             	cmp    $0x55,%eax
  102c91:	0f 87 44 03 00 00    	ja     102fdb <vprintfmt+0x3b3>
  102c97:	8b 04 85 74 3d 10 00 	mov    0x103d74(,%eax,4),%eax
  102c9e:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102ca0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102ca4:	eb d6                	jmp    102c7c <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102ca6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102caa:	eb d0                	jmp    102c7c <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102cac:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102cb3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102cb6:	89 d0                	mov    %edx,%eax
  102cb8:	c1 e0 02             	shl    $0x2,%eax
  102cbb:	01 d0                	add    %edx,%eax
  102cbd:	01 c0                	add    %eax,%eax
  102cbf:	01 d8                	add    %ebx,%eax
  102cc1:	83 e8 30             	sub    $0x30,%eax
  102cc4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102cc7:	8b 45 10             	mov    0x10(%ebp),%eax
  102cca:	0f b6 00             	movzbl (%eax),%eax
  102ccd:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102cd0:	83 fb 2f             	cmp    $0x2f,%ebx
  102cd3:	7e 0b                	jle    102ce0 <vprintfmt+0xb8>
  102cd5:	83 fb 39             	cmp    $0x39,%ebx
  102cd8:	7f 06                	jg     102ce0 <vprintfmt+0xb8>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102cda:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  102cde:	eb d3                	jmp    102cb3 <vprintfmt+0x8b>
            goto process_precision;
  102ce0:	eb 33                	jmp    102d15 <vprintfmt+0xed>

        case '*':
            precision = va_arg(ap, int);
  102ce2:	8b 45 14             	mov    0x14(%ebp),%eax
  102ce5:	8d 50 04             	lea    0x4(%eax),%edx
  102ce8:	89 55 14             	mov    %edx,0x14(%ebp)
  102ceb:	8b 00                	mov    (%eax),%eax
  102ced:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102cf0:	eb 23                	jmp    102d15 <vprintfmt+0xed>

        case '.':
            if (width < 0)
  102cf2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102cf6:	79 0c                	jns    102d04 <vprintfmt+0xdc>
                width = 0;
  102cf8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102cff:	e9 78 ff ff ff       	jmp    102c7c <vprintfmt+0x54>
  102d04:	e9 73 ff ff ff       	jmp    102c7c <vprintfmt+0x54>

        case '#':
            altflag = 1;
  102d09:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102d10:	e9 67 ff ff ff       	jmp    102c7c <vprintfmt+0x54>

        process_precision:
            if (width < 0)
  102d15:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102d19:	79 12                	jns    102d2d <vprintfmt+0x105>
                width = precision, precision = -1;
  102d1b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102d1e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102d21:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102d28:	e9 4f ff ff ff       	jmp    102c7c <vprintfmt+0x54>
  102d2d:	e9 4a ff ff ff       	jmp    102c7c <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102d32:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  102d36:	e9 41 ff ff ff       	jmp    102c7c <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102d3b:	8b 45 14             	mov    0x14(%ebp),%eax
  102d3e:	8d 50 04             	lea    0x4(%eax),%edx
  102d41:	89 55 14             	mov    %edx,0x14(%ebp)
  102d44:	8b 00                	mov    (%eax),%eax
  102d46:	8b 55 0c             	mov    0xc(%ebp),%edx
  102d49:	89 54 24 04          	mov    %edx,0x4(%esp)
  102d4d:	89 04 24             	mov    %eax,(%esp)
  102d50:	8b 45 08             	mov    0x8(%ebp),%eax
  102d53:	ff d0                	call   *%eax
            break;
  102d55:	e9 ac 02 00 00       	jmp    103006 <vprintfmt+0x3de>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102d5a:	8b 45 14             	mov    0x14(%ebp),%eax
  102d5d:	8d 50 04             	lea    0x4(%eax),%edx
  102d60:	89 55 14             	mov    %edx,0x14(%ebp)
  102d63:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102d65:	85 db                	test   %ebx,%ebx
  102d67:	79 02                	jns    102d6b <vprintfmt+0x143>
                err = -err;
  102d69:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102d6b:	83 fb 06             	cmp    $0x6,%ebx
  102d6e:	7f 0b                	jg     102d7b <vprintfmt+0x153>
  102d70:	8b 34 9d 34 3d 10 00 	mov    0x103d34(,%ebx,4),%esi
  102d77:	85 f6                	test   %esi,%esi
  102d79:	75 23                	jne    102d9e <vprintfmt+0x176>
                printfmt(putch, putdat, "error %d", err);
  102d7b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102d7f:	c7 44 24 08 61 3d 10 	movl   $0x103d61,0x8(%esp)
  102d86:	00 
  102d87:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d8e:	8b 45 08             	mov    0x8(%ebp),%eax
  102d91:	89 04 24             	mov    %eax,(%esp)
  102d94:	e8 61 fe ff ff       	call   102bfa <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102d99:	e9 68 02 00 00       	jmp    103006 <vprintfmt+0x3de>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  102d9e:	89 74 24 0c          	mov    %esi,0xc(%esp)
  102da2:	c7 44 24 08 6a 3d 10 	movl   $0x103d6a,0x8(%esp)
  102da9:	00 
  102daa:	8b 45 0c             	mov    0xc(%ebp),%eax
  102dad:	89 44 24 04          	mov    %eax,0x4(%esp)
  102db1:	8b 45 08             	mov    0x8(%ebp),%eax
  102db4:	89 04 24             	mov    %eax,(%esp)
  102db7:	e8 3e fe ff ff       	call   102bfa <printfmt>
            }
            break;
  102dbc:	e9 45 02 00 00       	jmp    103006 <vprintfmt+0x3de>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102dc1:	8b 45 14             	mov    0x14(%ebp),%eax
  102dc4:	8d 50 04             	lea    0x4(%eax),%edx
  102dc7:	89 55 14             	mov    %edx,0x14(%ebp)
  102dca:	8b 30                	mov    (%eax),%esi
  102dcc:	85 f6                	test   %esi,%esi
  102dce:	75 05                	jne    102dd5 <vprintfmt+0x1ad>
                p = "(null)";
  102dd0:	be 6d 3d 10 00       	mov    $0x103d6d,%esi
            }
            if (width > 0 && padc != '-') {
  102dd5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102dd9:	7e 3e                	jle    102e19 <vprintfmt+0x1f1>
  102ddb:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102ddf:	74 38                	je     102e19 <vprintfmt+0x1f1>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102de1:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  102de4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102de7:	89 44 24 04          	mov    %eax,0x4(%esp)
  102deb:	89 34 24             	mov    %esi,(%esp)
  102dee:	e8 15 03 00 00       	call   103108 <strnlen>
  102df3:	29 c3                	sub    %eax,%ebx
  102df5:	89 d8                	mov    %ebx,%eax
  102df7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102dfa:	eb 17                	jmp    102e13 <vprintfmt+0x1eb>
                    putch(padc, putdat);
  102dfc:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102e00:	8b 55 0c             	mov    0xc(%ebp),%edx
  102e03:	89 54 24 04          	mov    %edx,0x4(%esp)
  102e07:	89 04 24             	mov    %eax,(%esp)
  102e0a:	8b 45 08             	mov    0x8(%ebp),%eax
  102e0d:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  102e0f:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102e13:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e17:	7f e3                	jg     102dfc <vprintfmt+0x1d4>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102e19:	eb 38                	jmp    102e53 <vprintfmt+0x22b>
                if (altflag && (ch < ' ' || ch > '~')) {
  102e1b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102e1f:	74 1f                	je     102e40 <vprintfmt+0x218>
  102e21:	83 fb 1f             	cmp    $0x1f,%ebx
  102e24:	7e 05                	jle    102e2b <vprintfmt+0x203>
  102e26:	83 fb 7e             	cmp    $0x7e,%ebx
  102e29:	7e 15                	jle    102e40 <vprintfmt+0x218>
                    putch('?', putdat);
  102e2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e2e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e32:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  102e39:	8b 45 08             	mov    0x8(%ebp),%eax
  102e3c:	ff d0                	call   *%eax
  102e3e:	eb 0f                	jmp    102e4f <vprintfmt+0x227>
                }
                else {
                    putch(ch, putdat);
  102e40:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e43:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e47:	89 1c 24             	mov    %ebx,(%esp)
  102e4a:	8b 45 08             	mov    0x8(%ebp),%eax
  102e4d:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102e4f:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102e53:	89 f0                	mov    %esi,%eax
  102e55:	8d 70 01             	lea    0x1(%eax),%esi
  102e58:	0f b6 00             	movzbl (%eax),%eax
  102e5b:	0f be d8             	movsbl %al,%ebx
  102e5e:	85 db                	test   %ebx,%ebx
  102e60:	74 10                	je     102e72 <vprintfmt+0x24a>
  102e62:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102e66:	78 b3                	js     102e1b <vprintfmt+0x1f3>
  102e68:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102e6c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102e70:	79 a9                	jns    102e1b <vprintfmt+0x1f3>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102e72:	eb 17                	jmp    102e8b <vprintfmt+0x263>
                putch(' ', putdat);
  102e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e77:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e7b:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  102e82:	8b 45 08             	mov    0x8(%ebp),%eax
  102e85:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102e87:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102e8b:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102e8f:	7f e3                	jg     102e74 <vprintfmt+0x24c>
                putch(' ', putdat);
            }
            break;
  102e91:	e9 70 01 00 00       	jmp    103006 <vprintfmt+0x3de>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102e96:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102e99:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e9d:	8d 45 14             	lea    0x14(%ebp),%eax
  102ea0:	89 04 24             	mov    %eax,(%esp)
  102ea3:	e8 0b fd ff ff       	call   102bb3 <getint>
  102ea8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102eab:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102eae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102eb1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102eb4:	85 d2                	test   %edx,%edx
  102eb6:	79 26                	jns    102ede <vprintfmt+0x2b6>
                putch('-', putdat);
  102eb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ebb:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ebf:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  102ec6:	8b 45 08             	mov    0x8(%ebp),%eax
  102ec9:	ff d0                	call   *%eax
                num = -(long long)num;
  102ecb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ece:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ed1:	f7 d8                	neg    %eax
  102ed3:	83 d2 00             	adc    $0x0,%edx
  102ed6:	f7 da                	neg    %edx
  102ed8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102edb:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102ede:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102ee5:	e9 a8 00 00 00       	jmp    102f92 <vprintfmt+0x36a>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102eea:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102eed:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ef1:	8d 45 14             	lea    0x14(%ebp),%eax
  102ef4:	89 04 24             	mov    %eax,(%esp)
  102ef7:	e8 68 fc ff ff       	call   102b64 <getuint>
  102efc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102eff:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  102f02:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102f09:	e9 84 00 00 00       	jmp    102f92 <vprintfmt+0x36a>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  102f0e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f11:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f15:	8d 45 14             	lea    0x14(%ebp),%eax
  102f18:	89 04 24             	mov    %eax,(%esp)
  102f1b:	e8 44 fc ff ff       	call   102b64 <getuint>
  102f20:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f23:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  102f26:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  102f2d:	eb 63                	jmp    102f92 <vprintfmt+0x36a>

        // pointer
        case 'p':
            putch('0', putdat);
  102f2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f32:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f36:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  102f3d:	8b 45 08             	mov    0x8(%ebp),%eax
  102f40:	ff d0                	call   *%eax
            putch('x', putdat);
  102f42:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f45:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f49:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  102f50:	8b 45 08             	mov    0x8(%ebp),%eax
  102f53:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  102f55:	8b 45 14             	mov    0x14(%ebp),%eax
  102f58:	8d 50 04             	lea    0x4(%eax),%edx
  102f5b:	89 55 14             	mov    %edx,0x14(%ebp)
  102f5e:	8b 00                	mov    (%eax),%eax
  102f60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f63:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  102f6a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  102f71:	eb 1f                	jmp    102f92 <vprintfmt+0x36a>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  102f73:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102f76:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f7a:	8d 45 14             	lea    0x14(%ebp),%eax
  102f7d:	89 04 24             	mov    %eax,(%esp)
  102f80:	e8 df fb ff ff       	call   102b64 <getuint>
  102f85:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102f88:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  102f8b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  102f92:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  102f96:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102f99:	89 54 24 18          	mov    %edx,0x18(%esp)
  102f9d:	8b 55 e8             	mov    -0x18(%ebp),%edx
  102fa0:	89 54 24 14          	mov    %edx,0x14(%esp)
  102fa4:	89 44 24 10          	mov    %eax,0x10(%esp)
  102fa8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fab:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102fae:	89 44 24 08          	mov    %eax,0x8(%esp)
  102fb2:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102fb6:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fb9:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  102fc0:	89 04 24             	mov    %eax,(%esp)
  102fc3:	e8 97 fa ff ff       	call   102a5f <printnum>
            break;
  102fc8:	eb 3c                	jmp    103006 <vprintfmt+0x3de>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  102fca:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fcd:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fd1:	89 1c 24             	mov    %ebx,(%esp)
  102fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  102fd7:	ff d0                	call   *%eax
            break;
  102fd9:	eb 2b                	jmp    103006 <vprintfmt+0x3de>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  102fdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fde:	89 44 24 04          	mov    %eax,0x4(%esp)
  102fe2:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  102fe9:	8b 45 08             	mov    0x8(%ebp),%eax
  102fec:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  102fee:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102ff2:	eb 04                	jmp    102ff8 <vprintfmt+0x3d0>
  102ff4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102ff8:	8b 45 10             	mov    0x10(%ebp),%eax
  102ffb:	83 e8 01             	sub    $0x1,%eax
  102ffe:	0f b6 00             	movzbl (%eax),%eax
  103001:	3c 25                	cmp    $0x25,%al
  103003:	75 ef                	jne    102ff4 <vprintfmt+0x3cc>
                /* do nothing */;
            break;
  103005:	90                   	nop
        }
    }
  103006:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103007:	e9 3e fc ff ff       	jmp    102c4a <vprintfmt+0x22>
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  10300c:	83 c4 40             	add    $0x40,%esp
  10300f:	5b                   	pop    %ebx
  103010:	5e                   	pop    %esi
  103011:	5d                   	pop    %ebp
  103012:	c3                   	ret    

00103013 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  103013:	55                   	push   %ebp
  103014:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  103016:	8b 45 0c             	mov    0xc(%ebp),%eax
  103019:	8b 40 08             	mov    0x8(%eax),%eax
  10301c:	8d 50 01             	lea    0x1(%eax),%edx
  10301f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103022:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  103025:	8b 45 0c             	mov    0xc(%ebp),%eax
  103028:	8b 10                	mov    (%eax),%edx
  10302a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10302d:	8b 40 04             	mov    0x4(%eax),%eax
  103030:	39 c2                	cmp    %eax,%edx
  103032:	73 12                	jae    103046 <sprintputch+0x33>
        *b->buf ++ = ch;
  103034:	8b 45 0c             	mov    0xc(%ebp),%eax
  103037:	8b 00                	mov    (%eax),%eax
  103039:	8d 48 01             	lea    0x1(%eax),%ecx
  10303c:	8b 55 0c             	mov    0xc(%ebp),%edx
  10303f:	89 0a                	mov    %ecx,(%edx)
  103041:	8b 55 08             	mov    0x8(%ebp),%edx
  103044:	88 10                	mov    %dl,(%eax)
    }
}
  103046:	5d                   	pop    %ebp
  103047:	c3                   	ret    

00103048 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103048:	55                   	push   %ebp
  103049:	89 e5                	mov    %esp,%ebp
  10304b:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  10304e:	8d 45 14             	lea    0x14(%ebp),%eax
  103051:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  103054:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103057:	89 44 24 0c          	mov    %eax,0xc(%esp)
  10305b:	8b 45 10             	mov    0x10(%ebp),%eax
  10305e:	89 44 24 08          	mov    %eax,0x8(%esp)
  103062:	8b 45 0c             	mov    0xc(%ebp),%eax
  103065:	89 44 24 04          	mov    %eax,0x4(%esp)
  103069:	8b 45 08             	mov    0x8(%ebp),%eax
  10306c:	89 04 24             	mov    %eax,(%esp)
  10306f:	e8 08 00 00 00       	call   10307c <vsnprintf>
  103074:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103077:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10307a:	c9                   	leave  
  10307b:	c3                   	ret    

0010307c <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  10307c:	55                   	push   %ebp
  10307d:	89 e5                	mov    %esp,%ebp
  10307f:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  103082:	8b 45 08             	mov    0x8(%ebp),%eax
  103085:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103088:	8b 45 0c             	mov    0xc(%ebp),%eax
  10308b:	8d 50 ff             	lea    -0x1(%eax),%edx
  10308e:	8b 45 08             	mov    0x8(%ebp),%eax
  103091:	01 d0                	add    %edx,%eax
  103093:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103096:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  10309d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1030a1:	74 0a                	je     1030ad <vsnprintf+0x31>
  1030a3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1030a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1030a9:	39 c2                	cmp    %eax,%edx
  1030ab:	76 07                	jbe    1030b4 <vsnprintf+0x38>
        return -E_INVAL;
  1030ad:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  1030b2:	eb 2a                	jmp    1030de <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  1030b4:	8b 45 14             	mov    0x14(%ebp),%eax
  1030b7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1030bb:	8b 45 10             	mov    0x10(%ebp),%eax
  1030be:	89 44 24 08          	mov    %eax,0x8(%esp)
  1030c2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  1030c5:	89 44 24 04          	mov    %eax,0x4(%esp)
  1030c9:	c7 04 24 13 30 10 00 	movl   $0x103013,(%esp)
  1030d0:	e8 53 fb ff ff       	call   102c28 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  1030d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1030d8:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  1030db:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1030de:	c9                   	leave  
  1030df:	c3                   	ret    

001030e0 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  1030e0:	55                   	push   %ebp
  1030e1:	89 e5                	mov    %esp,%ebp
  1030e3:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1030e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  1030ed:	eb 04                	jmp    1030f3 <strlen+0x13>
        cnt ++;
  1030ef:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  1030f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1030f6:	8d 50 01             	lea    0x1(%eax),%edx
  1030f9:	89 55 08             	mov    %edx,0x8(%ebp)
  1030fc:	0f b6 00             	movzbl (%eax),%eax
  1030ff:	84 c0                	test   %al,%al
  103101:	75 ec                	jne    1030ef <strlen+0xf>
        cnt ++;
    }
    return cnt;
  103103:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  103106:	c9                   	leave  
  103107:	c3                   	ret    

00103108 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  103108:	55                   	push   %ebp
  103109:	89 e5                	mov    %esp,%ebp
  10310b:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  10310e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  103115:	eb 04                	jmp    10311b <strnlen+0x13>
        cnt ++;
  103117:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  10311b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10311e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  103121:	73 10                	jae    103133 <strnlen+0x2b>
  103123:	8b 45 08             	mov    0x8(%ebp),%eax
  103126:	8d 50 01             	lea    0x1(%eax),%edx
  103129:	89 55 08             	mov    %edx,0x8(%ebp)
  10312c:	0f b6 00             	movzbl (%eax),%eax
  10312f:	84 c0                	test   %al,%al
  103131:	75 e4                	jne    103117 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  103133:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  103136:	c9                   	leave  
  103137:	c3                   	ret    

00103138 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  103138:	55                   	push   %ebp
  103139:	89 e5                	mov    %esp,%ebp
  10313b:	57                   	push   %edi
  10313c:	56                   	push   %esi
  10313d:	83 ec 20             	sub    $0x20,%esp
  103140:	8b 45 08             	mov    0x8(%ebp),%eax
  103143:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103146:	8b 45 0c             	mov    0xc(%ebp),%eax
  103149:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  10314c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10314f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103152:	89 d1                	mov    %edx,%ecx
  103154:	89 c2                	mov    %eax,%edx
  103156:	89 ce                	mov    %ecx,%esi
  103158:	89 d7                	mov    %edx,%edi
  10315a:	ac                   	lods   %ds:(%esi),%al
  10315b:	aa                   	stos   %al,%es:(%edi)
  10315c:	84 c0                	test   %al,%al
  10315e:	75 fa                	jne    10315a <strcpy+0x22>
  103160:	89 fa                	mov    %edi,%edx
  103162:	89 f1                	mov    %esi,%ecx
  103164:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  103167:	89 55 e8             	mov    %edx,-0x18(%ebp)
  10316a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  10316d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  103170:	83 c4 20             	add    $0x20,%esp
  103173:	5e                   	pop    %esi
  103174:	5f                   	pop    %edi
  103175:	5d                   	pop    %ebp
  103176:	c3                   	ret    

00103177 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  103177:	55                   	push   %ebp
  103178:	89 e5                	mov    %esp,%ebp
  10317a:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  10317d:	8b 45 08             	mov    0x8(%ebp),%eax
  103180:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  103183:	eb 21                	jmp    1031a6 <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  103185:	8b 45 0c             	mov    0xc(%ebp),%eax
  103188:	0f b6 10             	movzbl (%eax),%edx
  10318b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10318e:	88 10                	mov    %dl,(%eax)
  103190:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103193:	0f b6 00             	movzbl (%eax),%eax
  103196:	84 c0                	test   %al,%al
  103198:	74 04                	je     10319e <strncpy+0x27>
            src ++;
  10319a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  10319e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1031a2:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  1031a6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1031aa:	75 d9                	jne    103185 <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  1031ac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1031af:	c9                   	leave  
  1031b0:	c3                   	ret    

001031b1 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  1031b1:	55                   	push   %ebp
  1031b2:	89 e5                	mov    %esp,%ebp
  1031b4:	57                   	push   %edi
  1031b5:	56                   	push   %esi
  1031b6:	83 ec 20             	sub    $0x20,%esp
  1031b9:	8b 45 08             	mov    0x8(%ebp),%eax
  1031bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1031bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  1031c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1031c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1031cb:	89 d1                	mov    %edx,%ecx
  1031cd:	89 c2                	mov    %eax,%edx
  1031cf:	89 ce                	mov    %ecx,%esi
  1031d1:	89 d7                	mov    %edx,%edi
  1031d3:	ac                   	lods   %ds:(%esi),%al
  1031d4:	ae                   	scas   %es:(%edi),%al
  1031d5:	75 08                	jne    1031df <strcmp+0x2e>
  1031d7:	84 c0                	test   %al,%al
  1031d9:	75 f8                	jne    1031d3 <strcmp+0x22>
  1031db:	31 c0                	xor    %eax,%eax
  1031dd:	eb 04                	jmp    1031e3 <strcmp+0x32>
  1031df:	19 c0                	sbb    %eax,%eax
  1031e1:	0c 01                	or     $0x1,%al
  1031e3:	89 fa                	mov    %edi,%edx
  1031e5:	89 f1                	mov    %esi,%ecx
  1031e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1031ea:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  1031ed:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            "orb $1, %%al;"
            "3:"
            : "=a" (ret), "=&S" (d0), "=&D" (d1)
            : "1" (s1), "2" (s2)
            : "memory");
    return ret;
  1031f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  1031f3:	83 c4 20             	add    $0x20,%esp
  1031f6:	5e                   	pop    %esi
  1031f7:	5f                   	pop    %edi
  1031f8:	5d                   	pop    %ebp
  1031f9:	c3                   	ret    

001031fa <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  1031fa:	55                   	push   %ebp
  1031fb:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  1031fd:	eb 0c                	jmp    10320b <strncmp+0x11>
        n --, s1 ++, s2 ++;
  1031ff:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103203:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103207:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  10320b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10320f:	74 1a                	je     10322b <strncmp+0x31>
  103211:	8b 45 08             	mov    0x8(%ebp),%eax
  103214:	0f b6 00             	movzbl (%eax),%eax
  103217:	84 c0                	test   %al,%al
  103219:	74 10                	je     10322b <strncmp+0x31>
  10321b:	8b 45 08             	mov    0x8(%ebp),%eax
  10321e:	0f b6 10             	movzbl (%eax),%edx
  103221:	8b 45 0c             	mov    0xc(%ebp),%eax
  103224:	0f b6 00             	movzbl (%eax),%eax
  103227:	38 c2                	cmp    %al,%dl
  103229:	74 d4                	je     1031ff <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  10322b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10322f:	74 18                	je     103249 <strncmp+0x4f>
  103231:	8b 45 08             	mov    0x8(%ebp),%eax
  103234:	0f b6 00             	movzbl (%eax),%eax
  103237:	0f b6 d0             	movzbl %al,%edx
  10323a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10323d:	0f b6 00             	movzbl (%eax),%eax
  103240:	0f b6 c0             	movzbl %al,%eax
  103243:	29 c2                	sub    %eax,%edx
  103245:	89 d0                	mov    %edx,%eax
  103247:	eb 05                	jmp    10324e <strncmp+0x54>
  103249:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10324e:	5d                   	pop    %ebp
  10324f:	c3                   	ret    

00103250 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  103250:	55                   	push   %ebp
  103251:	89 e5                	mov    %esp,%ebp
  103253:	83 ec 04             	sub    $0x4,%esp
  103256:	8b 45 0c             	mov    0xc(%ebp),%eax
  103259:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  10325c:	eb 14                	jmp    103272 <strchr+0x22>
        if (*s == c) {
  10325e:	8b 45 08             	mov    0x8(%ebp),%eax
  103261:	0f b6 00             	movzbl (%eax),%eax
  103264:	3a 45 fc             	cmp    -0x4(%ebp),%al
  103267:	75 05                	jne    10326e <strchr+0x1e>
            return (char *)s;
  103269:	8b 45 08             	mov    0x8(%ebp),%eax
  10326c:	eb 13                	jmp    103281 <strchr+0x31>
        }
        s ++;
  10326e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  103272:	8b 45 08             	mov    0x8(%ebp),%eax
  103275:	0f b6 00             	movzbl (%eax),%eax
  103278:	84 c0                	test   %al,%al
  10327a:	75 e2                	jne    10325e <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  10327c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103281:	c9                   	leave  
  103282:	c3                   	ret    

00103283 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  103283:	55                   	push   %ebp
  103284:	89 e5                	mov    %esp,%ebp
  103286:	83 ec 04             	sub    $0x4,%esp
  103289:	8b 45 0c             	mov    0xc(%ebp),%eax
  10328c:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  10328f:	eb 11                	jmp    1032a2 <strfind+0x1f>
        if (*s == c) {
  103291:	8b 45 08             	mov    0x8(%ebp),%eax
  103294:	0f b6 00             	movzbl (%eax),%eax
  103297:	3a 45 fc             	cmp    -0x4(%ebp),%al
  10329a:	75 02                	jne    10329e <strfind+0x1b>
            break;
  10329c:	eb 0e                	jmp    1032ac <strfind+0x29>
        }
        s ++;
  10329e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  1032a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1032a5:	0f b6 00             	movzbl (%eax),%eax
  1032a8:	84 c0                	test   %al,%al
  1032aa:	75 e5                	jne    103291 <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  1032ac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1032af:	c9                   	leave  
  1032b0:	c3                   	ret    

001032b1 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  1032b1:	55                   	push   %ebp
  1032b2:	89 e5                	mov    %esp,%ebp
  1032b4:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  1032b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  1032be:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1032c5:	eb 04                	jmp    1032cb <strtol+0x1a>
        s ++;
  1032c7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1032cb:	8b 45 08             	mov    0x8(%ebp),%eax
  1032ce:	0f b6 00             	movzbl (%eax),%eax
  1032d1:	3c 20                	cmp    $0x20,%al
  1032d3:	74 f2                	je     1032c7 <strtol+0x16>
  1032d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1032d8:	0f b6 00             	movzbl (%eax),%eax
  1032db:	3c 09                	cmp    $0x9,%al
  1032dd:	74 e8                	je     1032c7 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  1032df:	8b 45 08             	mov    0x8(%ebp),%eax
  1032e2:	0f b6 00             	movzbl (%eax),%eax
  1032e5:	3c 2b                	cmp    $0x2b,%al
  1032e7:	75 06                	jne    1032ef <strtol+0x3e>
        s ++;
  1032e9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1032ed:	eb 15                	jmp    103304 <strtol+0x53>
    }
    else if (*s == '-') {
  1032ef:	8b 45 08             	mov    0x8(%ebp),%eax
  1032f2:	0f b6 00             	movzbl (%eax),%eax
  1032f5:	3c 2d                	cmp    $0x2d,%al
  1032f7:	75 0b                	jne    103304 <strtol+0x53>
        s ++, neg = 1;
  1032f9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1032fd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  103304:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103308:	74 06                	je     103310 <strtol+0x5f>
  10330a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  10330e:	75 24                	jne    103334 <strtol+0x83>
  103310:	8b 45 08             	mov    0x8(%ebp),%eax
  103313:	0f b6 00             	movzbl (%eax),%eax
  103316:	3c 30                	cmp    $0x30,%al
  103318:	75 1a                	jne    103334 <strtol+0x83>
  10331a:	8b 45 08             	mov    0x8(%ebp),%eax
  10331d:	83 c0 01             	add    $0x1,%eax
  103320:	0f b6 00             	movzbl (%eax),%eax
  103323:	3c 78                	cmp    $0x78,%al
  103325:	75 0d                	jne    103334 <strtol+0x83>
        s += 2, base = 16;
  103327:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  10332b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  103332:	eb 2a                	jmp    10335e <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  103334:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103338:	75 17                	jne    103351 <strtol+0xa0>
  10333a:	8b 45 08             	mov    0x8(%ebp),%eax
  10333d:	0f b6 00             	movzbl (%eax),%eax
  103340:	3c 30                	cmp    $0x30,%al
  103342:	75 0d                	jne    103351 <strtol+0xa0>
        s ++, base = 8;
  103344:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103348:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  10334f:	eb 0d                	jmp    10335e <strtol+0xad>
    }
    else if (base == 0) {
  103351:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103355:	75 07                	jne    10335e <strtol+0xad>
        base = 10;
  103357:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  10335e:	8b 45 08             	mov    0x8(%ebp),%eax
  103361:	0f b6 00             	movzbl (%eax),%eax
  103364:	3c 2f                	cmp    $0x2f,%al
  103366:	7e 1b                	jle    103383 <strtol+0xd2>
  103368:	8b 45 08             	mov    0x8(%ebp),%eax
  10336b:	0f b6 00             	movzbl (%eax),%eax
  10336e:	3c 39                	cmp    $0x39,%al
  103370:	7f 11                	jg     103383 <strtol+0xd2>
            dig = *s - '0';
  103372:	8b 45 08             	mov    0x8(%ebp),%eax
  103375:	0f b6 00             	movzbl (%eax),%eax
  103378:	0f be c0             	movsbl %al,%eax
  10337b:	83 e8 30             	sub    $0x30,%eax
  10337e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103381:	eb 48                	jmp    1033cb <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  103383:	8b 45 08             	mov    0x8(%ebp),%eax
  103386:	0f b6 00             	movzbl (%eax),%eax
  103389:	3c 60                	cmp    $0x60,%al
  10338b:	7e 1b                	jle    1033a8 <strtol+0xf7>
  10338d:	8b 45 08             	mov    0x8(%ebp),%eax
  103390:	0f b6 00             	movzbl (%eax),%eax
  103393:	3c 7a                	cmp    $0x7a,%al
  103395:	7f 11                	jg     1033a8 <strtol+0xf7>
            dig = *s - 'a' + 10;
  103397:	8b 45 08             	mov    0x8(%ebp),%eax
  10339a:	0f b6 00             	movzbl (%eax),%eax
  10339d:	0f be c0             	movsbl %al,%eax
  1033a0:	83 e8 57             	sub    $0x57,%eax
  1033a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1033a6:	eb 23                	jmp    1033cb <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  1033a8:	8b 45 08             	mov    0x8(%ebp),%eax
  1033ab:	0f b6 00             	movzbl (%eax),%eax
  1033ae:	3c 40                	cmp    $0x40,%al
  1033b0:	7e 3d                	jle    1033ef <strtol+0x13e>
  1033b2:	8b 45 08             	mov    0x8(%ebp),%eax
  1033b5:	0f b6 00             	movzbl (%eax),%eax
  1033b8:	3c 5a                	cmp    $0x5a,%al
  1033ba:	7f 33                	jg     1033ef <strtol+0x13e>
            dig = *s - 'A' + 10;
  1033bc:	8b 45 08             	mov    0x8(%ebp),%eax
  1033bf:	0f b6 00             	movzbl (%eax),%eax
  1033c2:	0f be c0             	movsbl %al,%eax
  1033c5:	83 e8 37             	sub    $0x37,%eax
  1033c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1033cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1033ce:	3b 45 10             	cmp    0x10(%ebp),%eax
  1033d1:	7c 02                	jl     1033d5 <strtol+0x124>
            break;
  1033d3:	eb 1a                	jmp    1033ef <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  1033d5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  1033d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1033dc:	0f af 45 10          	imul   0x10(%ebp),%eax
  1033e0:	89 c2                	mov    %eax,%edx
  1033e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1033e5:	01 d0                	add    %edx,%eax
  1033e7:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  1033ea:	e9 6f ff ff ff       	jmp    10335e <strtol+0xad>

    if (endptr) {
  1033ef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  1033f3:	74 08                	je     1033fd <strtol+0x14c>
        *endptr = (char *) s;
  1033f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033f8:	8b 55 08             	mov    0x8(%ebp),%edx
  1033fb:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  1033fd:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  103401:	74 07                	je     10340a <strtol+0x159>
  103403:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103406:	f7 d8                	neg    %eax
  103408:	eb 03                	jmp    10340d <strtol+0x15c>
  10340a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  10340d:	c9                   	leave  
  10340e:	c3                   	ret    

0010340f <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  10340f:	55                   	push   %ebp
  103410:	89 e5                	mov    %esp,%ebp
  103412:	57                   	push   %edi
  103413:	83 ec 24             	sub    $0x24,%esp
  103416:	8b 45 0c             	mov    0xc(%ebp),%eax
  103419:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  10341c:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  103420:	8b 55 08             	mov    0x8(%ebp),%edx
  103423:	89 55 f8             	mov    %edx,-0x8(%ebp)
  103426:	88 45 f7             	mov    %al,-0x9(%ebp)
  103429:	8b 45 10             	mov    0x10(%ebp),%eax
  10342c:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  10342f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  103432:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  103436:	8b 55 f8             	mov    -0x8(%ebp),%edx
  103439:	89 d7                	mov    %edx,%edi
  10343b:	f3 aa                	rep stos %al,%es:(%edi)
  10343d:	89 fa                	mov    %edi,%edx
  10343f:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  103442:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  103445:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  103448:	83 c4 24             	add    $0x24,%esp
  10344b:	5f                   	pop    %edi
  10344c:	5d                   	pop    %ebp
  10344d:	c3                   	ret    

0010344e <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  10344e:	55                   	push   %ebp
  10344f:	89 e5                	mov    %esp,%ebp
  103451:	57                   	push   %edi
  103452:	56                   	push   %esi
  103453:	53                   	push   %ebx
  103454:	83 ec 30             	sub    $0x30,%esp
  103457:	8b 45 08             	mov    0x8(%ebp),%eax
  10345a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10345d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103460:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103463:	8b 45 10             	mov    0x10(%ebp),%eax
  103466:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  103469:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10346c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10346f:	73 42                	jae    1034b3 <memmove+0x65>
  103471:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103474:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  103477:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10347a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  10347d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  103480:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  103483:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103486:	c1 e8 02             	shr    $0x2,%eax
  103489:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  10348b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10348e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  103491:	89 d7                	mov    %edx,%edi
  103493:	89 c6                	mov    %eax,%esi
  103495:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  103497:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  10349a:	83 e1 03             	and    $0x3,%ecx
  10349d:	74 02                	je     1034a1 <memmove+0x53>
  10349f:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1034a1:	89 f0                	mov    %esi,%eax
  1034a3:	89 fa                	mov    %edi,%edx
  1034a5:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  1034a8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1034ab:	89 45 d0             	mov    %eax,-0x30(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  1034ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1034b1:	eb 36                	jmp    1034e9 <memmove+0x9b>
    asm volatile (
            "std;"
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  1034b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034b6:	8d 50 ff             	lea    -0x1(%eax),%edx
  1034b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1034bc:	01 c2                	add    %eax,%edx
  1034be:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034c1:	8d 48 ff             	lea    -0x1(%eax),%ecx
  1034c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1034c7:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  1034ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1034cd:	89 c1                	mov    %eax,%ecx
  1034cf:	89 d8                	mov    %ebx,%eax
  1034d1:	89 d6                	mov    %edx,%esi
  1034d3:	89 c7                	mov    %eax,%edi
  1034d5:	fd                   	std    
  1034d6:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1034d8:	fc                   	cld    
  1034d9:	89 f8                	mov    %edi,%eax
  1034db:	89 f2                	mov    %esi,%edx
  1034dd:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  1034e0:	89 55 c8             	mov    %edx,-0x38(%ebp)
  1034e3:	89 45 c4             	mov    %eax,-0x3c(%ebp)
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
            : "memory");
    return dst;
  1034e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  1034e9:	83 c4 30             	add    $0x30,%esp
  1034ec:	5b                   	pop    %ebx
  1034ed:	5e                   	pop    %esi
  1034ee:	5f                   	pop    %edi
  1034ef:	5d                   	pop    %ebp
  1034f0:	c3                   	ret    

001034f1 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  1034f1:	55                   	push   %ebp
  1034f2:	89 e5                	mov    %esp,%ebp
  1034f4:	57                   	push   %edi
  1034f5:	56                   	push   %esi
  1034f6:	83 ec 20             	sub    $0x20,%esp
  1034f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1034fc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1034ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  103502:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103505:	8b 45 10             	mov    0x10(%ebp),%eax
  103508:	89 45 ec             	mov    %eax,-0x14(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  10350b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10350e:	c1 e8 02             	shr    $0x2,%eax
  103511:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  103513:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103516:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103519:	89 d7                	mov    %edx,%edi
  10351b:	89 c6                	mov    %eax,%esi
  10351d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  10351f:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103522:	83 e1 03             	and    $0x3,%ecx
  103525:	74 02                	je     103529 <memcpy+0x38>
  103527:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103529:	89 f0                	mov    %esi,%eax
  10352b:	89 fa                	mov    %edi,%edx
  10352d:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  103530:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103533:	89 45 e0             	mov    %eax,-0x20(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  103536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  103539:	83 c4 20             	add    $0x20,%esp
  10353c:	5e                   	pop    %esi
  10353d:	5f                   	pop    %edi
  10353e:	5d                   	pop    %ebp
  10353f:	c3                   	ret    

00103540 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  103540:	55                   	push   %ebp
  103541:	89 e5                	mov    %esp,%ebp
  103543:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  103546:	8b 45 08             	mov    0x8(%ebp),%eax
  103549:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  10354c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10354f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  103552:	eb 30                	jmp    103584 <memcmp+0x44>
        if (*s1 != *s2) {
  103554:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103557:	0f b6 10             	movzbl (%eax),%edx
  10355a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10355d:	0f b6 00             	movzbl (%eax),%eax
  103560:	38 c2                	cmp    %al,%dl
  103562:	74 18                	je     10357c <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  103564:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103567:	0f b6 00             	movzbl (%eax),%eax
  10356a:	0f b6 d0             	movzbl %al,%edx
  10356d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103570:	0f b6 00             	movzbl (%eax),%eax
  103573:	0f b6 c0             	movzbl %al,%eax
  103576:	29 c2                	sub    %eax,%edx
  103578:	89 d0                	mov    %edx,%eax
  10357a:	eb 1a                	jmp    103596 <memcmp+0x56>
        }
        s1 ++, s2 ++;
  10357c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  103580:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  103584:	8b 45 10             	mov    0x10(%ebp),%eax
  103587:	8d 50 ff             	lea    -0x1(%eax),%edx
  10358a:	89 55 10             	mov    %edx,0x10(%ebp)
  10358d:	85 c0                	test   %eax,%eax
  10358f:	75 c3                	jne    103554 <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  103591:	b8 00 00 00 00       	mov    $0x0,%eax
}
  103596:	c9                   	leave  
  103597:	c3                   	ret    
