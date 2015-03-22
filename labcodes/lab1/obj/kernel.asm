
bin/kernel:     file format elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 28             	sub    $0x28,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 20 fd 10 00       	mov    $0x10fd20,%edx
  10000b:	b8 16 ea 10 00       	mov    $0x10ea16,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	89 44 24 08          	mov    %eax,0x8(%esp)
  100018:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  10001f:	00 
  100020:	c7 04 24 16 ea 10 00 	movl   $0x10ea16,(%esp)
  100027:	e8 13 33 00 00       	call   10333f <memset>

    cons_init();                // init the console
  10002c:	e8 72 15 00 00       	call   1015a3 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  100031:	c7 45 f4 e0 34 10 00 	movl   $0x1034e0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100038:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10003b:	89 44 24 04          	mov    %eax,0x4(%esp)
  10003f:	c7 04 24 fc 34 10 00 	movl   $0x1034fc,(%esp)
  100046:	e8 c7 02 00 00       	call   100312 <cprintf>

    print_kerninfo();
  10004b:	e8 f6 07 00 00       	call   100846 <print_kerninfo>

    grade_backtrace();
  100050:	e8 86 00 00 00       	call   1000db <grade_backtrace>

    pmm_init();                 // init physical memory management
  100055:	e8 2b 29 00 00       	call   102985 <pmm_init>

    pic_init();                 // init interrupt controller
  10005a:	e8 87 16 00 00       	call   1016e6 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005f:	e8 ff 17 00 00       	call   101863 <idt_init>

    clock_init();               // init clock interrupt
  100064:	e8 2d 0d 00 00       	call   100d96 <clock_init>
    intr_enable();              // enable irq interrupt
  100069:	e8 e6 15 00 00       	call   101654 <intr_enable>
    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    //lab1_switch_test();

    /* do nothing */
    while (1);
  10006e:	eb fe                	jmp    10006e <kern_init+0x6e>

00100070 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100070:	55                   	push   %ebp
  100071:	89 e5                	mov    %esp,%ebp
  100073:	83 ec 18             	sub    $0x18,%esp
    mon_backtrace(0, NULL, NULL);
  100076:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
  10007d:	00 
  10007e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  100085:	00 
  100086:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  10008d:	e8 36 0c 00 00       	call   100cc8 <mon_backtrace>
}
  100092:	c9                   	leave  
  100093:	c3                   	ret    

00100094 <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  100094:	55                   	push   %ebp
  100095:	89 e5                	mov    %esp,%ebp
  100097:	53                   	push   %ebx
  100098:	83 ec 14             	sub    $0x14,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  10009b:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  10009e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  1000a1:	8d 55 08             	lea    0x8(%ebp),%edx
  1000a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1000a7:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  1000ab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  1000af:	89 54 24 04          	mov    %edx,0x4(%esp)
  1000b3:	89 04 24             	mov    %eax,(%esp)
  1000b6:	e8 b5 ff ff ff       	call   100070 <grade_backtrace2>
}
  1000bb:	83 c4 14             	add    $0x14,%esp
  1000be:	5b                   	pop    %ebx
  1000bf:	5d                   	pop    %ebp
  1000c0:	c3                   	ret    

001000c1 <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000c1:	55                   	push   %ebp
  1000c2:	89 e5                	mov    %esp,%ebp
  1000c4:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace1(arg0, arg2);
  1000c7:	8b 45 10             	mov    0x10(%ebp),%eax
  1000ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000ce:	8b 45 08             	mov    0x8(%ebp),%eax
  1000d1:	89 04 24             	mov    %eax,(%esp)
  1000d4:	e8 bb ff ff ff       	call   100094 <grade_backtrace1>
}
  1000d9:	c9                   	leave  
  1000da:	c3                   	ret    

001000db <grade_backtrace>:

void
grade_backtrace(void) {
  1000db:	55                   	push   %ebp
  1000dc:	89 e5                	mov    %esp,%ebp
  1000de:	83 ec 18             	sub    $0x18,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000e1:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000e6:	c7 44 24 08 00 00 ff 	movl   $0xffff0000,0x8(%esp)
  1000ed:	ff 
  1000ee:	89 44 24 04          	mov    %eax,0x4(%esp)
  1000f2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  1000f9:	e8 c3 ff ff ff       	call   1000c1 <grade_backtrace0>
}
  1000fe:	c9                   	leave  
  1000ff:	c3                   	ret    

00100100 <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  100100:	55                   	push   %ebp
  100101:	89 e5                	mov    %esp,%ebp
  100103:	83 ec 28             	sub    $0x28,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  100106:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  100109:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  10010c:	8c 45 f2             	mov    %es,-0xe(%ebp)
  10010f:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  100112:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100116:	0f b7 c0             	movzwl %ax,%eax
  100119:	83 e0 03             	and    $0x3,%eax
  10011c:	89 c2                	mov    %eax,%edx
  10011e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100123:	89 54 24 08          	mov    %edx,0x8(%esp)
  100127:	89 44 24 04          	mov    %eax,0x4(%esp)
  10012b:	c7 04 24 01 35 10 00 	movl   $0x103501,(%esp)
  100132:	e8 db 01 00 00       	call   100312 <cprintf>
    cprintf("%d:  cs = %x\n", round, reg1);
  100137:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  10013b:	0f b7 d0             	movzwl %ax,%edx
  10013e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100143:	89 54 24 08          	mov    %edx,0x8(%esp)
  100147:	89 44 24 04          	mov    %eax,0x4(%esp)
  10014b:	c7 04 24 0f 35 10 00 	movl   $0x10350f,(%esp)
  100152:	e8 bb 01 00 00       	call   100312 <cprintf>
    cprintf("%d:  ds = %x\n", round, reg2);
  100157:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  10015b:	0f b7 d0             	movzwl %ax,%edx
  10015e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100163:	89 54 24 08          	mov    %edx,0x8(%esp)
  100167:	89 44 24 04          	mov    %eax,0x4(%esp)
  10016b:	c7 04 24 1d 35 10 00 	movl   $0x10351d,(%esp)
  100172:	e8 9b 01 00 00       	call   100312 <cprintf>
    cprintf("%d:  es = %x\n", round, reg3);
  100177:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10017b:	0f b7 d0             	movzwl %ax,%edx
  10017e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100183:	89 54 24 08          	mov    %edx,0x8(%esp)
  100187:	89 44 24 04          	mov    %eax,0x4(%esp)
  10018b:	c7 04 24 2b 35 10 00 	movl   $0x10352b,(%esp)
  100192:	e8 7b 01 00 00       	call   100312 <cprintf>
    cprintf("%d:  ss = %x\n", round, reg4);
  100197:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  10019b:	0f b7 d0             	movzwl %ax,%edx
  10019e:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001a3:	89 54 24 08          	mov    %edx,0x8(%esp)
  1001a7:	89 44 24 04          	mov    %eax,0x4(%esp)
  1001ab:	c7 04 24 39 35 10 00 	movl   $0x103539,(%esp)
  1001b2:	e8 5b 01 00 00       	call   100312 <cprintf>
    round ++;
  1001b7:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  1001bc:	83 c0 01             	add    $0x1,%eax
  1001bf:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  1001c4:	c9                   	leave  
  1001c5:	c3                   	ret    

001001c6 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001c6:	55                   	push   %ebp
  1001c7:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
}
  1001c9:	5d                   	pop    %ebp
  1001ca:	c3                   	ret    

001001cb <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001cb:	55                   	push   %ebp
  1001cc:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
}
  1001ce:	5d                   	pop    %ebp
  1001cf:	c3                   	ret    

001001d0 <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001d0:	55                   	push   %ebp
  1001d1:	89 e5                	mov    %esp,%ebp
  1001d3:	83 ec 18             	sub    $0x18,%esp
    lab1_print_cur_status();
  1001d6:	e8 25 ff ff ff       	call   100100 <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001db:	c7 04 24 48 35 10 00 	movl   $0x103548,(%esp)
  1001e2:	e8 2b 01 00 00       	call   100312 <cprintf>
    lab1_switch_to_user();
  1001e7:	e8 da ff ff ff       	call   1001c6 <lab1_switch_to_user>
    lab1_print_cur_status();
  1001ec:	e8 0f ff ff ff       	call   100100 <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  1001f1:	c7 04 24 68 35 10 00 	movl   $0x103568,(%esp)
  1001f8:	e8 15 01 00 00       	call   100312 <cprintf>
    lab1_switch_to_kernel();
  1001fd:	e8 c9 ff ff ff       	call   1001cb <lab1_switch_to_kernel>
    lab1_print_cur_status();
  100202:	e8 f9 fe ff ff       	call   100100 <lab1_print_cur_status>
}
  100207:	c9                   	leave  
  100208:	c3                   	ret    

00100209 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  100209:	55                   	push   %ebp
  10020a:	89 e5                	mov    %esp,%ebp
  10020c:	83 ec 28             	sub    $0x28,%esp
    if (prompt != NULL) {
  10020f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100213:	74 13                	je     100228 <readline+0x1f>
        cprintf("%s", prompt);
  100215:	8b 45 08             	mov    0x8(%ebp),%eax
  100218:	89 44 24 04          	mov    %eax,0x4(%esp)
  10021c:	c7 04 24 87 35 10 00 	movl   $0x103587,(%esp)
  100223:	e8 ea 00 00 00       	call   100312 <cprintf>
    }
    int i = 0, c;
  100228:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  10022f:	e8 66 01 00 00       	call   10039a <getchar>
  100234:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  100237:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  10023b:	79 07                	jns    100244 <readline+0x3b>
            return NULL;
  10023d:	b8 00 00 00 00       	mov    $0x0,%eax
  100242:	eb 79                	jmp    1002bd <readline+0xb4>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  100244:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100248:	7e 28                	jle    100272 <readline+0x69>
  10024a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  100251:	7f 1f                	jg     100272 <readline+0x69>
            cputchar(c);
  100253:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100256:	89 04 24             	mov    %eax,(%esp)
  100259:	e8 da 00 00 00       	call   100338 <cputchar>
            buf[i ++] = c;
  10025e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100261:	8d 50 01             	lea    0x1(%eax),%edx
  100264:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100267:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10026a:	88 90 40 ea 10 00    	mov    %dl,0x10ea40(%eax)
  100270:	eb 46                	jmp    1002b8 <readline+0xaf>
        }
        else if (c == '\b' && i > 0) {
  100272:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  100276:	75 17                	jne    10028f <readline+0x86>
  100278:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10027c:	7e 11                	jle    10028f <readline+0x86>
            cputchar(c);
  10027e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100281:	89 04 24             	mov    %eax,(%esp)
  100284:	e8 af 00 00 00       	call   100338 <cputchar>
            i --;
  100289:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10028d:	eb 29                	jmp    1002b8 <readline+0xaf>
        }
        else if (c == '\n' || c == '\r') {
  10028f:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  100293:	74 06                	je     10029b <readline+0x92>
  100295:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  100299:	75 1d                	jne    1002b8 <readline+0xaf>
            cputchar(c);
  10029b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10029e:	89 04 24             	mov    %eax,(%esp)
  1002a1:	e8 92 00 00 00       	call   100338 <cputchar>
            buf[i] = '\0';
  1002a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1002a9:	05 40 ea 10 00       	add    $0x10ea40,%eax
  1002ae:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1002b1:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  1002b6:	eb 05                	jmp    1002bd <readline+0xb4>
        }
    }
  1002b8:	e9 72 ff ff ff       	jmp    10022f <readline+0x26>
}
  1002bd:	c9                   	leave  
  1002be:	c3                   	ret    

001002bf <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  1002bf:	55                   	push   %ebp
  1002c0:	89 e5                	mov    %esp,%ebp
  1002c2:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  1002c5:	8b 45 08             	mov    0x8(%ebp),%eax
  1002c8:	89 04 24             	mov    %eax,(%esp)
  1002cb:	e8 ff 12 00 00       	call   1015cf <cons_putc>
    (*cnt) ++;
  1002d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002d3:	8b 00                	mov    (%eax),%eax
  1002d5:	8d 50 01             	lea    0x1(%eax),%edx
  1002d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002db:	89 10                	mov    %edx,(%eax)
}
  1002dd:	c9                   	leave  
  1002de:	c3                   	ret    

001002df <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  1002df:	55                   	push   %ebp
  1002e0:	89 e5                	mov    %esp,%ebp
  1002e2:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  1002e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  1002ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  1002ef:	89 44 24 0c          	mov    %eax,0xc(%esp)
  1002f3:	8b 45 08             	mov    0x8(%ebp),%eax
  1002f6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1002fa:	8d 45 f4             	lea    -0xc(%ebp),%eax
  1002fd:	89 44 24 04          	mov    %eax,0x4(%esp)
  100301:	c7 04 24 bf 02 10 00 	movl   $0x1002bf,(%esp)
  100308:	e8 4b 28 00 00       	call   102b58 <vprintfmt>
    return cnt;
  10030d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100310:	c9                   	leave  
  100311:	c3                   	ret    

00100312 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  100312:	55                   	push   %ebp
  100313:	89 e5                	mov    %esp,%ebp
  100315:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100318:	8d 45 0c             	lea    0xc(%ebp),%eax
  10031b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  10031e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100321:	89 44 24 04          	mov    %eax,0x4(%esp)
  100325:	8b 45 08             	mov    0x8(%ebp),%eax
  100328:	89 04 24             	mov    %eax,(%esp)
  10032b:	e8 af ff ff ff       	call   1002df <vcprintf>
  100330:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  100333:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100336:	c9                   	leave  
  100337:	c3                   	ret    

00100338 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100338:	55                   	push   %ebp
  100339:	89 e5                	mov    %esp,%ebp
  10033b:	83 ec 18             	sub    $0x18,%esp
    cons_putc(c);
  10033e:	8b 45 08             	mov    0x8(%ebp),%eax
  100341:	89 04 24             	mov    %eax,(%esp)
  100344:	e8 86 12 00 00       	call   1015cf <cons_putc>
}
  100349:	c9                   	leave  
  10034a:	c3                   	ret    

0010034b <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10034b:	55                   	push   %ebp
  10034c:	89 e5                	mov    %esp,%ebp
  10034e:	83 ec 28             	sub    $0x28,%esp
    int cnt = 0;
  100351:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100358:	eb 13                	jmp    10036d <cputs+0x22>
        cputch(c, &cnt);
  10035a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10035e:	8d 55 f0             	lea    -0x10(%ebp),%edx
  100361:	89 54 24 04          	mov    %edx,0x4(%esp)
  100365:	89 04 24             	mov    %eax,(%esp)
  100368:	e8 52 ff ff ff       	call   1002bf <cputch>
 * */
int
cputs(const char *str) {
    int cnt = 0;
    char c;
    while ((c = *str ++) != '\0') {
  10036d:	8b 45 08             	mov    0x8(%ebp),%eax
  100370:	8d 50 01             	lea    0x1(%eax),%edx
  100373:	89 55 08             	mov    %edx,0x8(%ebp)
  100376:	0f b6 00             	movzbl (%eax),%eax
  100379:	88 45 f7             	mov    %al,-0x9(%ebp)
  10037c:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  100380:	75 d8                	jne    10035a <cputs+0xf>
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
  100382:	8d 45 f0             	lea    -0x10(%ebp),%eax
  100385:	89 44 24 04          	mov    %eax,0x4(%esp)
  100389:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
  100390:	e8 2a ff ff ff       	call   1002bf <cputch>
    return cnt;
  100395:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  100398:	c9                   	leave  
  100399:	c3                   	ret    

0010039a <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  10039a:	55                   	push   %ebp
  10039b:	89 e5                	mov    %esp,%ebp
  10039d:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1003a0:	e8 53 12 00 00       	call   1015f8 <cons_getc>
  1003a5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1003a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1003ac:	74 f2                	je     1003a0 <getchar+0x6>
        /* do nothing */;
    return c;
  1003ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1003b1:	c9                   	leave  
  1003b2:	c3                   	ret    

001003b3 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  1003b3:	55                   	push   %ebp
  1003b4:	89 e5                	mov    %esp,%ebp
  1003b6:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  1003b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1003bc:	8b 00                	mov    (%eax),%eax
  1003be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  1003c1:	8b 45 10             	mov    0x10(%ebp),%eax
  1003c4:	8b 00                	mov    (%eax),%eax
  1003c6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  1003c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1003d0:	e9 d2 00 00 00       	jmp    1004a7 <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  1003d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1003d8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1003db:	01 d0                	add    %edx,%eax
  1003dd:	89 c2                	mov    %eax,%edx
  1003df:	c1 ea 1f             	shr    $0x1f,%edx
  1003e2:	01 d0                	add    %edx,%eax
  1003e4:	d1 f8                	sar    %eax
  1003e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1003e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1003ec:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1003ef:	eb 04                	jmp    1003f5 <stab_binsearch+0x42>
            m --;
  1003f1:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)

    while (l <= r) {
        int true_m = (l + r) / 2, m = true_m;

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1003f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1003f8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1003fb:	7c 1f                	jl     10041c <stab_binsearch+0x69>
  1003fd:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100400:	89 d0                	mov    %edx,%eax
  100402:	01 c0                	add    %eax,%eax
  100404:	01 d0                	add    %edx,%eax
  100406:	c1 e0 02             	shl    $0x2,%eax
  100409:	89 c2                	mov    %eax,%edx
  10040b:	8b 45 08             	mov    0x8(%ebp),%eax
  10040e:	01 d0                	add    %edx,%eax
  100410:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100414:	0f b6 c0             	movzbl %al,%eax
  100417:	3b 45 14             	cmp    0x14(%ebp),%eax
  10041a:	75 d5                	jne    1003f1 <stab_binsearch+0x3e>
            m --;
        }
        if (m < l) {    // no match in [l, m]
  10041c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10041f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  100422:	7d 0b                	jge    10042f <stab_binsearch+0x7c>
            l = true_m + 1;
  100424:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100427:	83 c0 01             	add    $0x1,%eax
  10042a:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  10042d:	eb 78                	jmp    1004a7 <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  10042f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  100436:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100439:	89 d0                	mov    %edx,%eax
  10043b:	01 c0                	add    %eax,%eax
  10043d:	01 d0                	add    %edx,%eax
  10043f:	c1 e0 02             	shl    $0x2,%eax
  100442:	89 c2                	mov    %eax,%edx
  100444:	8b 45 08             	mov    0x8(%ebp),%eax
  100447:	01 d0                	add    %edx,%eax
  100449:	8b 40 08             	mov    0x8(%eax),%eax
  10044c:	3b 45 18             	cmp    0x18(%ebp),%eax
  10044f:	73 13                	jae    100464 <stab_binsearch+0xb1>
            *region_left = m;
  100451:	8b 45 0c             	mov    0xc(%ebp),%eax
  100454:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100457:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  100459:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10045c:	83 c0 01             	add    $0x1,%eax
  10045f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100462:	eb 43                	jmp    1004a7 <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  100464:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100467:	89 d0                	mov    %edx,%eax
  100469:	01 c0                	add    %eax,%eax
  10046b:	01 d0                	add    %edx,%eax
  10046d:	c1 e0 02             	shl    $0x2,%eax
  100470:	89 c2                	mov    %eax,%edx
  100472:	8b 45 08             	mov    0x8(%ebp),%eax
  100475:	01 d0                	add    %edx,%eax
  100477:	8b 40 08             	mov    0x8(%eax),%eax
  10047a:	3b 45 18             	cmp    0x18(%ebp),%eax
  10047d:	76 16                	jbe    100495 <stab_binsearch+0xe2>
            *region_right = m - 1;
  10047f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100482:	8d 50 ff             	lea    -0x1(%eax),%edx
  100485:	8b 45 10             	mov    0x10(%ebp),%eax
  100488:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  10048a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10048d:	83 e8 01             	sub    $0x1,%eax
  100490:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100493:	eb 12                	jmp    1004a7 <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  100495:	8b 45 0c             	mov    0xc(%ebp),%eax
  100498:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10049b:	89 10                	mov    %edx,(%eax)
            l = m;
  10049d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  1004a3:	83 45 18 01          	addl   $0x1,0x18(%ebp)
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
    int l = *region_left, r = *region_right, any_matches = 0;

    while (l <= r) {
  1004a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1004aa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  1004ad:	0f 8e 22 ff ff ff    	jle    1003d5 <stab_binsearch+0x22>
            l = m;
            addr ++;
        }
    }

    if (!any_matches) {
  1004b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1004b7:	75 0f                	jne    1004c8 <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  1004b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004bc:	8b 00                	mov    (%eax),%eax
  1004be:	8d 50 ff             	lea    -0x1(%eax),%edx
  1004c1:	8b 45 10             	mov    0x10(%ebp),%eax
  1004c4:	89 10                	mov    %edx,(%eax)
  1004c6:	eb 3f                	jmp    100507 <stab_binsearch+0x154>
    }
    else {
        // find rightmost region containing 'addr'
        l = *region_right;
  1004c8:	8b 45 10             	mov    0x10(%ebp),%eax
  1004cb:	8b 00                	mov    (%eax),%eax
  1004cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1004d0:	eb 04                	jmp    1004d6 <stab_binsearch+0x123>
  1004d2:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1004d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1004d9:	8b 00                	mov    (%eax),%eax
  1004db:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004de:	7d 1f                	jge    1004ff <stab_binsearch+0x14c>
  1004e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004e3:	89 d0                	mov    %edx,%eax
  1004e5:	01 c0                	add    %eax,%eax
  1004e7:	01 d0                	add    %edx,%eax
  1004e9:	c1 e0 02             	shl    $0x2,%eax
  1004ec:	89 c2                	mov    %eax,%edx
  1004ee:	8b 45 08             	mov    0x8(%ebp),%eax
  1004f1:	01 d0                	add    %edx,%eax
  1004f3:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1004f7:	0f b6 c0             	movzbl %al,%eax
  1004fa:	3b 45 14             	cmp    0x14(%ebp),%eax
  1004fd:	75 d3                	jne    1004d2 <stab_binsearch+0x11f>
            /* do nothing */;
        *region_left = l;
  1004ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  100502:	8b 55 fc             	mov    -0x4(%ebp),%edx
  100505:	89 10                	mov    %edx,(%eax)
    }
}
  100507:	c9                   	leave  
  100508:	c3                   	ret    

00100509 <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  100509:	55                   	push   %ebp
  10050a:	89 e5                	mov    %esp,%ebp
  10050c:	83 ec 58             	sub    $0x58,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  10050f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100512:	c7 00 8c 35 10 00    	movl   $0x10358c,(%eax)
    info->eip_line = 0;
  100518:	8b 45 0c             	mov    0xc(%ebp),%eax
  10051b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  100522:	8b 45 0c             	mov    0xc(%ebp),%eax
  100525:	c7 40 08 8c 35 10 00 	movl   $0x10358c,0x8(%eax)
    info->eip_fn_namelen = 9;
  10052c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10052f:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  100536:	8b 45 0c             	mov    0xc(%ebp),%eax
  100539:	8b 55 08             	mov    0x8(%ebp),%edx
  10053c:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  10053f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100542:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  100549:	c7 45 f4 0c 3e 10 00 	movl   $0x103e0c,-0xc(%ebp)
    stab_end = __STAB_END__;
  100550:	c7 45 f0 64 b5 10 00 	movl   $0x10b564,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  100557:	c7 45 ec 65 b5 10 00 	movl   $0x10b565,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  10055e:	c7 45 e8 66 d5 10 00 	movl   $0x10d566,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  100565:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100568:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10056b:	76 0d                	jbe    10057a <debuginfo_eip+0x71>
  10056d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100570:	83 e8 01             	sub    $0x1,%eax
  100573:	0f b6 00             	movzbl (%eax),%eax
  100576:	84 c0                	test   %al,%al
  100578:	74 0a                	je     100584 <debuginfo_eip+0x7b>
        return -1;
  10057a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10057f:	e9 c0 02 00 00       	jmp    100844 <debuginfo_eip+0x33b>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100584:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  10058b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10058e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100591:	29 c2                	sub    %eax,%edx
  100593:	89 d0                	mov    %edx,%eax
  100595:	c1 f8 02             	sar    $0x2,%eax
  100598:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  10059e:	83 e8 01             	sub    $0x1,%eax
  1005a1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  1005a4:	8b 45 08             	mov    0x8(%ebp),%eax
  1005a7:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005ab:	c7 44 24 0c 64 00 00 	movl   $0x64,0xc(%esp)
  1005b2:	00 
  1005b3:	8d 45 e0             	lea    -0x20(%ebp),%eax
  1005b6:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005ba:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  1005bd:	89 44 24 04          	mov    %eax,0x4(%esp)
  1005c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1005c4:	89 04 24             	mov    %eax,(%esp)
  1005c7:	e8 e7 fd ff ff       	call   1003b3 <stab_binsearch>
    if (lfile == 0)
  1005cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005cf:	85 c0                	test   %eax,%eax
  1005d1:	75 0a                	jne    1005dd <debuginfo_eip+0xd4>
        return -1;
  1005d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1005d8:	e9 67 02 00 00       	jmp    100844 <debuginfo_eip+0x33b>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1005dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1005e0:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1005e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1005e6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1005ec:	89 44 24 10          	mov    %eax,0x10(%esp)
  1005f0:	c7 44 24 0c 24 00 00 	movl   $0x24,0xc(%esp)
  1005f7:	00 
  1005f8:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1005fb:	89 44 24 08          	mov    %eax,0x8(%esp)
  1005ff:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100602:	89 44 24 04          	mov    %eax,0x4(%esp)
  100606:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100609:	89 04 24             	mov    %eax,(%esp)
  10060c:	e8 a2 fd ff ff       	call   1003b3 <stab_binsearch>

    if (lfun <= rfun) {
  100611:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100614:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100617:	39 c2                	cmp    %eax,%edx
  100619:	7f 7c                	jg     100697 <debuginfo_eip+0x18e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  10061b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10061e:	89 c2                	mov    %eax,%edx
  100620:	89 d0                	mov    %edx,%eax
  100622:	01 c0                	add    %eax,%eax
  100624:	01 d0                	add    %edx,%eax
  100626:	c1 e0 02             	shl    $0x2,%eax
  100629:	89 c2                	mov    %eax,%edx
  10062b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10062e:	01 d0                	add    %edx,%eax
  100630:	8b 10                	mov    (%eax),%edx
  100632:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100635:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100638:	29 c1                	sub    %eax,%ecx
  10063a:	89 c8                	mov    %ecx,%eax
  10063c:	39 c2                	cmp    %eax,%edx
  10063e:	73 22                	jae    100662 <debuginfo_eip+0x159>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  100640:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100643:	89 c2                	mov    %eax,%edx
  100645:	89 d0                	mov    %edx,%eax
  100647:	01 c0                	add    %eax,%eax
  100649:	01 d0                	add    %edx,%eax
  10064b:	c1 e0 02             	shl    $0x2,%eax
  10064e:	89 c2                	mov    %eax,%edx
  100650:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100653:	01 d0                	add    %edx,%eax
  100655:	8b 10                	mov    (%eax),%edx
  100657:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10065a:	01 c2                	add    %eax,%edx
  10065c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10065f:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100662:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100665:	89 c2                	mov    %eax,%edx
  100667:	89 d0                	mov    %edx,%eax
  100669:	01 c0                	add    %eax,%eax
  10066b:	01 d0                	add    %edx,%eax
  10066d:	c1 e0 02             	shl    $0x2,%eax
  100670:	89 c2                	mov    %eax,%edx
  100672:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100675:	01 d0                	add    %edx,%eax
  100677:	8b 50 08             	mov    0x8(%eax),%edx
  10067a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10067d:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100680:	8b 45 0c             	mov    0xc(%ebp),%eax
  100683:	8b 40 10             	mov    0x10(%eax),%eax
  100686:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  100689:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10068c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  10068f:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100692:	89 45 d0             	mov    %eax,-0x30(%ebp)
  100695:	eb 15                	jmp    1006ac <debuginfo_eip+0x1a3>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  100697:	8b 45 0c             	mov    0xc(%ebp),%eax
  10069a:	8b 55 08             	mov    0x8(%ebp),%edx
  10069d:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  1006a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006a3:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  1006a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006a9:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  1006ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006af:	8b 40 08             	mov    0x8(%eax),%eax
  1006b2:	c7 44 24 04 3a 00 00 	movl   $0x3a,0x4(%esp)
  1006b9:	00 
  1006ba:	89 04 24             	mov    %eax,(%esp)
  1006bd:	e8 f1 2a 00 00       	call   1031b3 <strfind>
  1006c2:	89 c2                	mov    %eax,%edx
  1006c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006c7:	8b 40 08             	mov    0x8(%eax),%eax
  1006ca:	29 c2                	sub    %eax,%edx
  1006cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  1006cf:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  1006d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1006d5:	89 44 24 10          	mov    %eax,0x10(%esp)
  1006d9:	c7 44 24 0c 44 00 00 	movl   $0x44,0xc(%esp)
  1006e0:	00 
  1006e1:	8d 45 d0             	lea    -0x30(%ebp),%eax
  1006e4:	89 44 24 08          	mov    %eax,0x8(%esp)
  1006e8:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  1006eb:	89 44 24 04          	mov    %eax,0x4(%esp)
  1006ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006f2:	89 04 24             	mov    %eax,(%esp)
  1006f5:	e8 b9 fc ff ff       	call   1003b3 <stab_binsearch>
    if (lline <= rline) {
  1006fa:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1006fd:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100700:	39 c2                	cmp    %eax,%edx
  100702:	7f 24                	jg     100728 <debuginfo_eip+0x21f>
        info->eip_line = stabs[rline].n_desc;
  100704:	8b 45 d0             	mov    -0x30(%ebp),%eax
  100707:	89 c2                	mov    %eax,%edx
  100709:	89 d0                	mov    %edx,%eax
  10070b:	01 c0                	add    %eax,%eax
  10070d:	01 d0                	add    %edx,%eax
  10070f:	c1 e0 02             	shl    $0x2,%eax
  100712:	89 c2                	mov    %eax,%edx
  100714:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100717:	01 d0                	add    %edx,%eax
  100719:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  10071d:	0f b7 d0             	movzwl %ax,%edx
  100720:	8b 45 0c             	mov    0xc(%ebp),%eax
  100723:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  100726:	eb 13                	jmp    10073b <debuginfo_eip+0x232>
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
    if (lline <= rline) {
        info->eip_line = stabs[rline].n_desc;
    } else {
        return -1;
  100728:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10072d:	e9 12 01 00 00       	jmp    100844 <debuginfo_eip+0x33b>
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  100732:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100735:	83 e8 01             	sub    $0x1,%eax
  100738:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  10073b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10073e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100741:	39 c2                	cmp    %eax,%edx
  100743:	7c 56                	jl     10079b <debuginfo_eip+0x292>
           && stabs[lline].n_type != N_SOL
  100745:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100748:	89 c2                	mov    %eax,%edx
  10074a:	89 d0                	mov    %edx,%eax
  10074c:	01 c0                	add    %eax,%eax
  10074e:	01 d0                	add    %edx,%eax
  100750:	c1 e0 02             	shl    $0x2,%eax
  100753:	89 c2                	mov    %eax,%edx
  100755:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100758:	01 d0                	add    %edx,%eax
  10075a:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10075e:	3c 84                	cmp    $0x84,%al
  100760:	74 39                	je     10079b <debuginfo_eip+0x292>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100762:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100765:	89 c2                	mov    %eax,%edx
  100767:	89 d0                	mov    %edx,%eax
  100769:	01 c0                	add    %eax,%eax
  10076b:	01 d0                	add    %edx,%eax
  10076d:	c1 e0 02             	shl    $0x2,%eax
  100770:	89 c2                	mov    %eax,%edx
  100772:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100775:	01 d0                	add    %edx,%eax
  100777:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10077b:	3c 64                	cmp    $0x64,%al
  10077d:	75 b3                	jne    100732 <debuginfo_eip+0x229>
  10077f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100782:	89 c2                	mov    %eax,%edx
  100784:	89 d0                	mov    %edx,%eax
  100786:	01 c0                	add    %eax,%eax
  100788:	01 d0                	add    %edx,%eax
  10078a:	c1 e0 02             	shl    $0x2,%eax
  10078d:	89 c2                	mov    %eax,%edx
  10078f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100792:	01 d0                	add    %edx,%eax
  100794:	8b 40 08             	mov    0x8(%eax),%eax
  100797:	85 c0                	test   %eax,%eax
  100799:	74 97                	je     100732 <debuginfo_eip+0x229>
        lline --;
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  10079b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10079e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007a1:	39 c2                	cmp    %eax,%edx
  1007a3:	7c 46                	jl     1007eb <debuginfo_eip+0x2e2>
  1007a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007a8:	89 c2                	mov    %eax,%edx
  1007aa:	89 d0                	mov    %edx,%eax
  1007ac:	01 c0                	add    %eax,%eax
  1007ae:	01 d0                	add    %edx,%eax
  1007b0:	c1 e0 02             	shl    $0x2,%eax
  1007b3:	89 c2                	mov    %eax,%edx
  1007b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007b8:	01 d0                	add    %edx,%eax
  1007ba:	8b 10                	mov    (%eax),%edx
  1007bc:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1007bf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007c2:	29 c1                	sub    %eax,%ecx
  1007c4:	89 c8                	mov    %ecx,%eax
  1007c6:	39 c2                	cmp    %eax,%edx
  1007c8:	73 21                	jae    1007eb <debuginfo_eip+0x2e2>
        info->eip_file = stabstr + stabs[lline].n_strx;
  1007ca:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007cd:	89 c2                	mov    %eax,%edx
  1007cf:	89 d0                	mov    %edx,%eax
  1007d1:	01 c0                	add    %eax,%eax
  1007d3:	01 d0                	add    %edx,%eax
  1007d5:	c1 e0 02             	shl    $0x2,%eax
  1007d8:	89 c2                	mov    %eax,%edx
  1007da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007dd:	01 d0                	add    %edx,%eax
  1007df:	8b 10                	mov    (%eax),%edx
  1007e1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1007e4:	01 c2                	add    %eax,%edx
  1007e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007e9:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  1007eb:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1007ee:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1007f1:	39 c2                	cmp    %eax,%edx
  1007f3:	7d 4a                	jge    10083f <debuginfo_eip+0x336>
        for (lline = lfun + 1;
  1007f5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1007f8:	83 c0 01             	add    $0x1,%eax
  1007fb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1007fe:	eb 18                	jmp    100818 <debuginfo_eip+0x30f>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  100800:	8b 45 0c             	mov    0xc(%ebp),%eax
  100803:	8b 40 14             	mov    0x14(%eax),%eax
  100806:	8d 50 01             	lea    0x1(%eax),%edx
  100809:	8b 45 0c             	mov    0xc(%ebp),%eax
  10080c:	89 50 14             	mov    %edx,0x14(%eax)
    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
  10080f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100812:	83 c0 01             	add    $0x1,%eax
  100815:	89 45 d4             	mov    %eax,-0x2c(%ebp)

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100818:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  10081b:	8b 45 d8             	mov    -0x28(%ebp),%eax
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
        for (lline = lfun + 1;
  10081e:	39 c2                	cmp    %eax,%edx
  100820:	7d 1d                	jge    10083f <debuginfo_eip+0x336>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  100822:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100825:	89 c2                	mov    %eax,%edx
  100827:	89 d0                	mov    %edx,%eax
  100829:	01 c0                	add    %eax,%eax
  10082b:	01 d0                	add    %edx,%eax
  10082d:	c1 e0 02             	shl    $0x2,%eax
  100830:	89 c2                	mov    %eax,%edx
  100832:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100835:	01 d0                	add    %edx,%eax
  100837:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  10083b:	3c a0                	cmp    $0xa0,%al
  10083d:	74 c1                	je     100800 <debuginfo_eip+0x2f7>
             lline ++) {
            info->eip_fn_narg ++;
        }
    }
    return 0;
  10083f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100844:	c9                   	leave  
  100845:	c3                   	ret    

00100846 <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  100846:	55                   	push   %ebp
  100847:	89 e5                	mov    %esp,%ebp
  100849:	83 ec 18             	sub    $0x18,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  10084c:	c7 04 24 96 35 10 00 	movl   $0x103596,(%esp)
  100853:	e8 ba fa ff ff       	call   100312 <cprintf>
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100858:	c7 44 24 04 00 00 10 	movl   $0x100000,0x4(%esp)
  10085f:	00 
  100860:	c7 04 24 af 35 10 00 	movl   $0x1035af,(%esp)
  100867:	e8 a6 fa ff ff       	call   100312 <cprintf>
    cprintf("  etext  0x%08x (phys)\n", etext);
  10086c:	c7 44 24 04 c8 34 10 	movl   $0x1034c8,0x4(%esp)
  100873:	00 
  100874:	c7 04 24 c7 35 10 00 	movl   $0x1035c7,(%esp)
  10087b:	e8 92 fa ff ff       	call   100312 <cprintf>
    cprintf("  edata  0x%08x (phys)\n", edata);
  100880:	c7 44 24 04 16 ea 10 	movl   $0x10ea16,0x4(%esp)
  100887:	00 
  100888:	c7 04 24 df 35 10 00 	movl   $0x1035df,(%esp)
  10088f:	e8 7e fa ff ff       	call   100312 <cprintf>
    cprintf("  end    0x%08x (phys)\n", end);
  100894:	c7 44 24 04 20 fd 10 	movl   $0x10fd20,0x4(%esp)
  10089b:	00 
  10089c:	c7 04 24 f7 35 10 00 	movl   $0x1035f7,(%esp)
  1008a3:	e8 6a fa ff ff       	call   100312 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  1008a8:	b8 20 fd 10 00       	mov    $0x10fd20,%eax
  1008ad:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008b3:	b8 00 00 10 00       	mov    $0x100000,%eax
  1008b8:	29 c2                	sub    %eax,%edx
  1008ba:	89 d0                	mov    %edx,%eax
  1008bc:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  1008c2:	85 c0                	test   %eax,%eax
  1008c4:	0f 48 c2             	cmovs  %edx,%eax
  1008c7:	c1 f8 0a             	sar    $0xa,%eax
  1008ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008ce:	c7 04 24 10 36 10 00 	movl   $0x103610,(%esp)
  1008d5:	e8 38 fa ff ff       	call   100312 <cprintf>
}
  1008da:	c9                   	leave  
  1008db:	c3                   	ret    

001008dc <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  1008dc:	55                   	push   %ebp
  1008dd:	89 e5                	mov    %esp,%ebp
  1008df:	81 ec 48 01 00 00    	sub    $0x148,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  1008e5:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1008e8:	89 44 24 04          	mov    %eax,0x4(%esp)
  1008ec:	8b 45 08             	mov    0x8(%ebp),%eax
  1008ef:	89 04 24             	mov    %eax,(%esp)
  1008f2:	e8 12 fc ff ff       	call   100509 <debuginfo_eip>
  1008f7:	85 c0                	test   %eax,%eax
  1008f9:	74 15                	je     100910 <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  1008fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1008fe:	89 44 24 04          	mov    %eax,0x4(%esp)
  100902:	c7 04 24 3a 36 10 00 	movl   $0x10363a,(%esp)
  100909:	e8 04 fa ff ff       	call   100312 <cprintf>
  10090e:	eb 6d                	jmp    10097d <print_debuginfo+0xa1>
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100910:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100917:	eb 1c                	jmp    100935 <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  100919:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  10091c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10091f:	01 d0                	add    %edx,%eax
  100921:	0f b6 00             	movzbl (%eax),%eax
  100924:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  10092a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10092d:	01 ca                	add    %ecx,%edx
  10092f:	88 02                	mov    %al,(%edx)
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
    }
    else {
        char fnname[256];
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  100931:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100935:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100938:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  10093b:	7f dc                	jg     100919 <print_debuginfo+0x3d>
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
  10093d:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  100943:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100946:	01 d0                	add    %edx,%eax
  100948:	c6 00 00             	movb   $0x0,(%eax)
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
  10094b:	8b 45 ec             	mov    -0x14(%ebp),%eax
        int j;
        for (j = 0; j < info.eip_fn_namelen; j ++) {
            fnname[j] = info.eip_fn_name[j];
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  10094e:	8b 55 08             	mov    0x8(%ebp),%edx
  100951:	89 d1                	mov    %edx,%ecx
  100953:	29 c1                	sub    %eax,%ecx
  100955:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100958:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10095b:	89 4c 24 10          	mov    %ecx,0x10(%esp)
  10095f:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100965:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100969:	89 54 24 08          	mov    %edx,0x8(%esp)
  10096d:	89 44 24 04          	mov    %eax,0x4(%esp)
  100971:	c7 04 24 56 36 10 00 	movl   $0x103656,(%esp)
  100978:	e8 95 f9 ff ff       	call   100312 <cprintf>
                fnname, eip - info.eip_fn_addr);
    }
}
  10097d:	c9                   	leave  
  10097e:	c3                   	ret    

0010097f <read_eip>:

static __noinline uint32_t
read_eip(void) {
  10097f:	55                   	push   %ebp
  100980:	89 e5                	mov    %esp,%ebp
  100982:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100985:	8b 45 04             	mov    0x4(%ebp),%eax
  100988:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  10098b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10098e:	c9                   	leave  
  10098f:	c3                   	ret    

00100990 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100990:	55                   	push   %ebp
  100991:	89 e5                	mov    %esp,%ebp
  100993:	53                   	push   %ebx
  100994:	83 ec 44             	sub    $0x44,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100997:	89 e8                	mov    %ebp,%eax
  100999:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return ebp;
  10099c:	8b 45 e8             	mov    -0x18(%ebp),%eax
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */

	uint32_t ebp= read_ebp(), eip= read_eip();
  10099f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1009a2:	e8 d8 ff ff ff       	call   10097f <read_eip>
  1009a7:	89 45 f0             	mov    %eax,-0x10(%ebp)

	int i=0;
  1009aa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
	while (ebp!=0 && (i++)<STACKFRAME_DEPTH )
  1009b1:	e9 b9 00 00 00       	jmp    100a6f <print_stackframe+0xdf>
	{
		uint32_t args[4]={0};
  1009b6:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  1009bd:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1009c4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  1009cb:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		asm volatile ("movl 8(%1), %0" : "=r" (args[0])  : "r"(ebp));
  1009d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009d5:	8b 40 08             	mov    0x8(%eax),%eax
  1009d8:	89 45 d8             	mov    %eax,-0x28(%ebp)
		asm volatile ("movl 12(%1), %0" : "=r" (args[1])  : "r"(ebp));
  1009db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009de:	8b 40 0c             	mov    0xc(%eax),%eax
  1009e1:	89 45 dc             	mov    %eax,-0x24(%ebp)
		asm volatile ("movl 16(%1), %0" : "=r" (args[2])  : "r"(ebp));
  1009e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009e7:	8b 40 10             	mov    0x10(%eax),%eax
  1009ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
		asm volatile ("movl 20(%1), %0" : "=r" (args[3])  : "r"(ebp));
  1009ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009f0:	8b 40 14             	mov    0x14(%eax),%eax
  1009f3:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		cprintf("ebp:0x%08x", ebp);
  1009f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009f9:	89 44 24 04          	mov    %eax,0x4(%esp)
  1009fd:	c7 04 24 68 36 10 00 	movl   $0x103668,(%esp)
  100a04:	e8 09 f9 ff ff       	call   100312 <cprintf>
		cprintf(" eip:0x%08x", eip);
  100a09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a0c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a10:	c7 04 24 73 36 10 00 	movl   $0x103673,(%esp)
  100a17:	e8 f6 f8 ff ff       	call   100312 <cprintf>
		cprintf(" args:0x%08x 0x%08x 0x%08x 0x%08x", args[0], args[1], args[2], args[3]);
  100a1c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
  100a1f:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  100a22:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100a25:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100a28:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  100a2c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  100a30:	89 54 24 08          	mov    %edx,0x8(%esp)
  100a34:	89 44 24 04          	mov    %eax,0x4(%esp)
  100a38:	c7 04 24 80 36 10 00 	movl   $0x103680,(%esp)
  100a3f:	e8 ce f8 ff ff       	call   100312 <cprintf>
		cprintf("\n");
  100a44:	c7 04 24 a2 36 10 00 	movl   $0x1036a2,(%esp)
  100a4b:	e8 c2 f8 ff ff       	call   100312 <cprintf>
		print_debuginfo(eip-1);
  100a50:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a53:	83 e8 01             	sub    $0x1,%eax
  100a56:	89 04 24             	mov    %eax,(%esp)
  100a59:	e8 7e fe ff ff       	call   1008dc <print_debuginfo>

		asm volatile ("movl 4(%1), %0" : "=r" (eip) : "r"(ebp));
  100a5e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a61:	8b 40 04             	mov    0x4(%eax),%eax
  100a64:	89 45 f0             	mov    %eax,-0x10(%ebp)
		asm volatile ("movl 0(%1), %0" : "=r" (ebp) : "r"(ebp));
  100a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a6a:	8b 00                	mov    (%eax),%eax
  100a6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      */

	uint32_t ebp= read_ebp(), eip= read_eip();

	int i=0;
	while (ebp!=0 && (i++)<STACKFRAME_DEPTH )
  100a6f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100a73:	74 12                	je     100a87 <print_stackframe+0xf7>
  100a75:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100a78:	8d 50 01             	lea    0x1(%eax),%edx
  100a7b:	89 55 ec             	mov    %edx,-0x14(%ebp)
  100a7e:	83 f8 13             	cmp    $0x13,%eax
  100a81:	0f 8e 2f ff ff ff    	jle    1009b6 <print_stackframe+0x26>
		print_debuginfo(eip-1);

		asm volatile ("movl 4(%1), %0" : "=r" (eip) : "r"(ebp));
		asm volatile ("movl 0(%1), %0" : "=r" (ebp) : "r"(ebp));
	}
}
  100a87:	83 c4 44             	add    $0x44,%esp
  100a8a:	5b                   	pop    %ebx
  100a8b:	5d                   	pop    %ebp
  100a8c:	c3                   	ret    

00100a8d <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100a8d:	55                   	push   %ebp
  100a8e:	89 e5                	mov    %esp,%ebp
  100a90:	83 ec 28             	sub    $0x28,%esp
    int argc = 0;
  100a93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100a9a:	eb 0c                	jmp    100aa8 <parse+0x1b>
            *buf ++ = '\0';
  100a9c:	8b 45 08             	mov    0x8(%ebp),%eax
  100a9f:	8d 50 01             	lea    0x1(%eax),%edx
  100aa2:	89 55 08             	mov    %edx,0x8(%ebp)
  100aa5:	c6 00 00             	movb   $0x0,(%eax)
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  100aab:	0f b6 00             	movzbl (%eax),%eax
  100aae:	84 c0                	test   %al,%al
  100ab0:	74 1d                	je     100acf <parse+0x42>
  100ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  100ab5:	0f b6 00             	movzbl (%eax),%eax
  100ab8:	0f be c0             	movsbl %al,%eax
  100abb:	89 44 24 04          	mov    %eax,0x4(%esp)
  100abf:	c7 04 24 24 37 10 00 	movl   $0x103724,(%esp)
  100ac6:	e8 b5 26 00 00       	call   103180 <strchr>
  100acb:	85 c0                	test   %eax,%eax
  100acd:	75 cd                	jne    100a9c <parse+0xf>
            *buf ++ = '\0';
        }
        if (*buf == '\0') {
  100acf:	8b 45 08             	mov    0x8(%ebp),%eax
  100ad2:	0f b6 00             	movzbl (%eax),%eax
  100ad5:	84 c0                	test   %al,%al
  100ad7:	75 02                	jne    100adb <parse+0x4e>
            break;
  100ad9:	eb 67                	jmp    100b42 <parse+0xb5>
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100adb:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100adf:	75 14                	jne    100af5 <parse+0x68>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100ae1:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
  100ae8:	00 
  100ae9:	c7 04 24 29 37 10 00 	movl   $0x103729,(%esp)
  100af0:	e8 1d f8 ff ff       	call   100312 <cprintf>
        }
        argv[argc ++] = buf;
  100af5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100af8:	8d 50 01             	lea    0x1(%eax),%edx
  100afb:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100afe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b05:	8b 45 0c             	mov    0xc(%ebp),%eax
  100b08:	01 c2                	add    %eax,%edx
  100b0a:	8b 45 08             	mov    0x8(%ebp),%eax
  100b0d:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b0f:	eb 04                	jmp    100b15 <parse+0x88>
            buf ++;
  100b11:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        // save and scan past next arg
        if (argc == MAXARGS - 1) {
            cprintf("Too many arguments (max %d).\n", MAXARGS);
        }
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b15:	8b 45 08             	mov    0x8(%ebp),%eax
  100b18:	0f b6 00             	movzbl (%eax),%eax
  100b1b:	84 c0                	test   %al,%al
  100b1d:	74 1d                	je     100b3c <parse+0xaf>
  100b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  100b22:	0f b6 00             	movzbl (%eax),%eax
  100b25:	0f be c0             	movsbl %al,%eax
  100b28:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b2c:	c7 04 24 24 37 10 00 	movl   $0x103724,(%esp)
  100b33:	e8 48 26 00 00       	call   103180 <strchr>
  100b38:	85 c0                	test   %eax,%eax
  100b3a:	74 d5                	je     100b11 <parse+0x84>
            buf ++;
        }
    }
  100b3c:	90                   	nop
static int
parse(char *buf, char **argv) {
    int argc = 0;
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100b3d:	e9 66 ff ff ff       	jmp    100aa8 <parse+0x1b>
        argv[argc ++] = buf;
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
            buf ++;
        }
    }
    return argc;
  100b42:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100b45:	c9                   	leave  
  100b46:	c3                   	ret    

00100b47 <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100b47:	55                   	push   %ebp
  100b48:	89 e5                	mov    %esp,%ebp
  100b4a:	83 ec 68             	sub    $0x68,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100b4d:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100b50:	89 44 24 04          	mov    %eax,0x4(%esp)
  100b54:	8b 45 08             	mov    0x8(%ebp),%eax
  100b57:	89 04 24             	mov    %eax,(%esp)
  100b5a:	e8 2e ff ff ff       	call   100a8d <parse>
  100b5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100b62:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100b66:	75 0a                	jne    100b72 <runcmd+0x2b>
        return 0;
  100b68:	b8 00 00 00 00       	mov    $0x0,%eax
  100b6d:	e9 85 00 00 00       	jmp    100bf7 <runcmd+0xb0>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100b72:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100b79:	eb 5c                	jmp    100bd7 <runcmd+0x90>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100b7b:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100b7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100b81:	89 d0                	mov    %edx,%eax
  100b83:	01 c0                	add    %eax,%eax
  100b85:	01 d0                	add    %edx,%eax
  100b87:	c1 e0 02             	shl    $0x2,%eax
  100b8a:	05 00 e0 10 00       	add    $0x10e000,%eax
  100b8f:	8b 00                	mov    (%eax),%eax
  100b91:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  100b95:	89 04 24             	mov    %eax,(%esp)
  100b98:	e8 44 25 00 00       	call   1030e1 <strcmp>
  100b9d:	85 c0                	test   %eax,%eax
  100b9f:	75 32                	jne    100bd3 <runcmd+0x8c>
            return commands[i].func(argc - 1, argv + 1, tf);
  100ba1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100ba4:	89 d0                	mov    %edx,%eax
  100ba6:	01 c0                	add    %eax,%eax
  100ba8:	01 d0                	add    %edx,%eax
  100baa:	c1 e0 02             	shl    $0x2,%eax
  100bad:	05 00 e0 10 00       	add    $0x10e000,%eax
  100bb2:	8b 40 08             	mov    0x8(%eax),%eax
  100bb5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100bb8:	8d 4a ff             	lea    -0x1(%edx),%ecx
  100bbb:	8b 55 0c             	mov    0xc(%ebp),%edx
  100bbe:	89 54 24 08          	mov    %edx,0x8(%esp)
  100bc2:	8d 55 b0             	lea    -0x50(%ebp),%edx
  100bc5:	83 c2 04             	add    $0x4,%edx
  100bc8:	89 54 24 04          	mov    %edx,0x4(%esp)
  100bcc:	89 0c 24             	mov    %ecx,(%esp)
  100bcf:	ff d0                	call   *%eax
  100bd1:	eb 24                	jmp    100bf7 <runcmd+0xb0>
    int argc = parse(buf, argv);
    if (argc == 0) {
        return 0;
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100bd3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100bd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100bda:	83 f8 02             	cmp    $0x2,%eax
  100bdd:	76 9c                	jbe    100b7b <runcmd+0x34>
        if (strcmp(commands[i].name, argv[0]) == 0) {
            return commands[i].func(argc - 1, argv + 1, tf);
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100bdf:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100be2:	89 44 24 04          	mov    %eax,0x4(%esp)
  100be6:	c7 04 24 47 37 10 00 	movl   $0x103747,(%esp)
  100bed:	e8 20 f7 ff ff       	call   100312 <cprintf>
    return 0;
  100bf2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100bf7:	c9                   	leave  
  100bf8:	c3                   	ret    

00100bf9 <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100bf9:	55                   	push   %ebp
  100bfa:	89 e5                	mov    %esp,%ebp
  100bfc:	83 ec 28             	sub    $0x28,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100bff:	c7 04 24 60 37 10 00 	movl   $0x103760,(%esp)
  100c06:	e8 07 f7 ff ff       	call   100312 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
  100c0b:	c7 04 24 88 37 10 00 	movl   $0x103788,(%esp)
  100c12:	e8 fb f6 ff ff       	call   100312 <cprintf>

    if (tf != NULL) {
  100c17:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100c1b:	74 0b                	je     100c28 <kmonitor+0x2f>
        print_trapframe(tf);
  100c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  100c20:	89 04 24             	mov    %eax,(%esp)
  100c23:	e8 f8 0d 00 00       	call   101a20 <print_trapframe>
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100c28:	c7 04 24 ad 37 10 00 	movl   $0x1037ad,(%esp)
  100c2f:	e8 d5 f5 ff ff       	call   100209 <readline>
  100c34:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c37:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c3b:	74 18                	je     100c55 <kmonitor+0x5c>
            if (runcmd(buf, tf) < 0) {
  100c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  100c40:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c47:	89 04 24             	mov    %eax,(%esp)
  100c4a:	e8 f8 fe ff ff       	call   100b47 <runcmd>
  100c4f:	85 c0                	test   %eax,%eax
  100c51:	79 02                	jns    100c55 <kmonitor+0x5c>
                break;
  100c53:	eb 02                	jmp    100c57 <kmonitor+0x5e>
            }
        }
    }
  100c55:	eb d1                	jmp    100c28 <kmonitor+0x2f>
}
  100c57:	c9                   	leave  
  100c58:	c3                   	ret    

00100c59 <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100c59:	55                   	push   %ebp
  100c5a:	89 e5                	mov    %esp,%ebp
  100c5c:	83 ec 28             	sub    $0x28,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100c5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100c66:	eb 3f                	jmp    100ca7 <mon_help+0x4e>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100c68:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c6b:	89 d0                	mov    %edx,%eax
  100c6d:	01 c0                	add    %eax,%eax
  100c6f:	01 d0                	add    %edx,%eax
  100c71:	c1 e0 02             	shl    $0x2,%eax
  100c74:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c79:	8b 48 04             	mov    0x4(%eax),%ecx
  100c7c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100c7f:	89 d0                	mov    %edx,%eax
  100c81:	01 c0                	add    %eax,%eax
  100c83:	01 d0                	add    %edx,%eax
  100c85:	c1 e0 02             	shl    $0x2,%eax
  100c88:	05 00 e0 10 00       	add    $0x10e000,%eax
  100c8d:	8b 00                	mov    (%eax),%eax
  100c8f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  100c93:	89 44 24 04          	mov    %eax,0x4(%esp)
  100c97:	c7 04 24 b1 37 10 00 	movl   $0x1037b1,(%esp)
  100c9e:	e8 6f f6 ff ff       	call   100312 <cprintf>

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100ca3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100ca7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100caa:	83 f8 02             	cmp    $0x2,%eax
  100cad:	76 b9                	jbe    100c68 <mon_help+0xf>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
    }
    return 0;
  100caf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cb4:	c9                   	leave  
  100cb5:	c3                   	ret    

00100cb6 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100cb6:	55                   	push   %ebp
  100cb7:	89 e5                	mov    %esp,%ebp
  100cb9:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100cbc:	e8 85 fb ff ff       	call   100846 <print_kerninfo>
    return 0;
  100cc1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cc6:	c9                   	leave  
  100cc7:	c3                   	ret    

00100cc8 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100cc8:	55                   	push   %ebp
  100cc9:	89 e5                	mov    %esp,%ebp
  100ccb:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100cce:	e8 bd fc ff ff       	call   100990 <print_stackframe>
    return 0;
  100cd3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100cd8:	c9                   	leave  
  100cd9:	c3                   	ret    

00100cda <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  100cda:	55                   	push   %ebp
  100cdb:	89 e5                	mov    %esp,%ebp
  100cdd:	83 ec 28             	sub    $0x28,%esp
    if (is_panic) {
  100ce0:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  100ce5:	85 c0                	test   %eax,%eax
  100ce7:	74 02                	je     100ceb <__panic+0x11>
        goto panic_dead;
  100ce9:	eb 48                	jmp    100d33 <__panic+0x59>
    }
    is_panic = 1;
  100ceb:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  100cf2:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  100cf5:	8d 45 14             	lea    0x14(%ebp),%eax
  100cf8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  100cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  100cfe:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d02:	8b 45 08             	mov    0x8(%ebp),%eax
  100d05:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d09:	c7 04 24 ba 37 10 00 	movl   $0x1037ba,(%esp)
  100d10:	e8 fd f5 ff ff       	call   100312 <cprintf>
    vcprintf(fmt, ap);
  100d15:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d18:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d1c:	8b 45 10             	mov    0x10(%ebp),%eax
  100d1f:	89 04 24             	mov    %eax,(%esp)
  100d22:	e8 b8 f5 ff ff       	call   1002df <vcprintf>
    cprintf("\n");
  100d27:	c7 04 24 d6 37 10 00 	movl   $0x1037d6,(%esp)
  100d2e:	e8 df f5 ff ff       	call   100312 <cprintf>
    va_end(ap);

panic_dead:
    intr_disable();
  100d33:	e8 22 09 00 00       	call   10165a <intr_disable>
    while (1) {
        kmonitor(NULL);
  100d38:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100d3f:	e8 b5 fe ff ff       	call   100bf9 <kmonitor>
    }
  100d44:	eb f2                	jmp    100d38 <__panic+0x5e>

00100d46 <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100d46:	55                   	push   %ebp
  100d47:	89 e5                	mov    %esp,%ebp
  100d49:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    va_start(ap, fmt);
  100d4c:	8d 45 14             	lea    0x14(%ebp),%eax
  100d4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100d52:	8b 45 0c             	mov    0xc(%ebp),%eax
  100d55:	89 44 24 08          	mov    %eax,0x8(%esp)
  100d59:	8b 45 08             	mov    0x8(%ebp),%eax
  100d5c:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d60:	c7 04 24 d8 37 10 00 	movl   $0x1037d8,(%esp)
  100d67:	e8 a6 f5 ff ff       	call   100312 <cprintf>
    vcprintf(fmt, ap);
  100d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100d6f:	89 44 24 04          	mov    %eax,0x4(%esp)
  100d73:	8b 45 10             	mov    0x10(%ebp),%eax
  100d76:	89 04 24             	mov    %eax,(%esp)
  100d79:	e8 61 f5 ff ff       	call   1002df <vcprintf>
    cprintf("\n");
  100d7e:	c7 04 24 d6 37 10 00 	movl   $0x1037d6,(%esp)
  100d85:	e8 88 f5 ff ff       	call   100312 <cprintf>
    va_end(ap);
}
  100d8a:	c9                   	leave  
  100d8b:	c3                   	ret    

00100d8c <is_kernel_panic>:

bool
is_kernel_panic(void) {
  100d8c:	55                   	push   %ebp
  100d8d:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100d8f:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  100d94:	5d                   	pop    %ebp
  100d95:	c3                   	ret    

00100d96 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100d96:	55                   	push   %ebp
  100d97:	89 e5                	mov    %esp,%ebp
  100d99:	83 ec 28             	sub    $0x28,%esp
  100d9c:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100da2:	c6 45 f5 34          	movb   $0x34,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100da6:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100daa:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100dae:	ee                   	out    %al,(%dx)
  100daf:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100db5:	c6 45 f1 9c          	movb   $0x9c,-0xf(%ebp)
  100db9:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100dbd:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100dc1:	ee                   	out    %al,(%dx)
  100dc2:	66 c7 45 ee 40 00    	movw   $0x40,-0x12(%ebp)
  100dc8:	c6 45 ed 2e          	movb   $0x2e,-0x13(%ebp)
  100dcc:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100dd0:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100dd4:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100dd5:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100ddc:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100ddf:	c7 04 24 f6 37 10 00 	movl   $0x1037f6,(%esp)
  100de6:	e8 27 f5 ff ff       	call   100312 <cprintf>
    pic_enable(IRQ_TIMER);
  100deb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  100df2:	e8 c1 08 00 00       	call   1016b8 <pic_enable>
}
  100df7:	c9                   	leave  
  100df8:	c3                   	ret    

00100df9 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100df9:	55                   	push   %ebp
  100dfa:	89 e5                	mov    %esp,%ebp
  100dfc:	83 ec 10             	sub    $0x10,%esp
  100dff:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e05:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100e09:	89 c2                	mov    %eax,%edx
  100e0b:	ec                   	in     (%dx),%al
  100e0c:	88 45 fd             	mov    %al,-0x3(%ebp)
  100e0f:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100e15:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100e19:	89 c2                	mov    %eax,%edx
  100e1b:	ec                   	in     (%dx),%al
  100e1c:	88 45 f9             	mov    %al,-0x7(%ebp)
  100e1f:	66 c7 45 f6 84 00    	movw   $0x84,-0xa(%ebp)
  100e25:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100e29:	89 c2                	mov    %eax,%edx
  100e2b:	ec                   	in     (%dx),%al
  100e2c:	88 45 f5             	mov    %al,-0xb(%ebp)
  100e2f:	66 c7 45 f2 84 00    	movw   $0x84,-0xe(%ebp)
  100e35:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e39:	89 c2                	mov    %eax,%edx
  100e3b:	ec                   	in     (%dx),%al
  100e3c:	88 45 f1             	mov    %al,-0xf(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100e3f:	c9                   	leave  
  100e40:	c3                   	ret    

00100e41 <cga_init>:
static uint16_t addr_6845;

/* TEXT-mode CGA/VGA display output */

static void
cga_init(void) {
  100e41:	55                   	push   %ebp
  100e42:	89 e5                	mov    %esp,%ebp
  100e44:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;
  100e47:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;
  100e4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e51:	0f b7 00             	movzwl (%eax),%eax
  100e54:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;
  100e58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e5b:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {
  100e60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e63:	0f b7 00             	movzwl (%eax),%eax
  100e66:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100e6a:	74 12                	je     100e7e <cga_init+0x3d>
        cp = (uint16_t*)MONO_BUF;
  100e6c:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;
  100e73:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100e7a:	b4 03 
  100e7c:	eb 13                	jmp    100e91 <cga_init+0x50>
    } else {
        *cp = was;
  100e7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e81:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100e85:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;
  100e88:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100e8f:	d4 03 
    }

    // Extract cursor location
    uint32_t pos;
    outb(addr_6845, 14);
  100e91:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e98:	0f b7 c0             	movzwl %ax,%eax
  100e9b:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  100e9f:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ea3:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100ea7:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100eab:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;
  100eac:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100eb3:	83 c0 01             	add    $0x1,%eax
  100eb6:	0f b7 c0             	movzwl %ax,%eax
  100eb9:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100ebd:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100ec1:	89 c2                	mov    %eax,%edx
  100ec3:	ec                   	in     (%dx),%al
  100ec4:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100ec7:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100ecb:	0f b6 c0             	movzbl %al,%eax
  100ece:	c1 e0 08             	shl    $0x8,%eax
  100ed1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100ed4:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100edb:	0f b7 c0             	movzwl %ax,%eax
  100ede:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  100ee2:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ee6:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100eea:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100eee:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);
  100eef:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100ef6:	83 c0 01             	add    $0x1,%eax
  100ef9:	0f b7 c0             	movzwl %ax,%eax
  100efc:	66 89 45 e6          	mov    %ax,-0x1a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f00:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
  100f04:	89 c2                	mov    %eax,%edx
  100f06:	ec                   	in     (%dx),%al
  100f07:	88 45 e5             	mov    %al,-0x1b(%ebp)
    return data;
  100f0a:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f0e:	0f b6 c0             	movzbl %al,%eax
  100f11:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;
  100f14:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100f17:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;
  100f1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100f1f:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100f25:	c9                   	leave  
  100f26:	c3                   	ret    

00100f27 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100f27:	55                   	push   %ebp
  100f28:	89 e5                	mov    %esp,%ebp
  100f2a:	83 ec 48             	sub    $0x48,%esp
  100f2d:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100f33:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100f37:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  100f3b:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100f3f:	ee                   	out    %al,(%dx)
  100f40:	66 c7 45 f2 fb 03    	movw   $0x3fb,-0xe(%ebp)
  100f46:	c6 45 f1 80          	movb   $0x80,-0xf(%ebp)
  100f4a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100f4e:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f52:	ee                   	out    %al,(%dx)
  100f53:	66 c7 45 ee f8 03    	movw   $0x3f8,-0x12(%ebp)
  100f59:	c6 45 ed 0c          	movb   $0xc,-0x13(%ebp)
  100f5d:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100f61:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f65:	ee                   	out    %al,(%dx)
  100f66:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100f6c:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
  100f70:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  100f74:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100f78:	ee                   	out    %al,(%dx)
  100f79:	66 c7 45 e6 fb 03    	movw   $0x3fb,-0x1a(%ebp)
  100f7f:	c6 45 e5 03          	movb   $0x3,-0x1b(%ebp)
  100f83:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  100f87:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  100f8b:	ee                   	out    %al,(%dx)
  100f8c:	66 c7 45 e2 fc 03    	movw   $0x3fc,-0x1e(%ebp)
  100f92:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
  100f96:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  100f9a:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  100f9e:	ee                   	out    %al,(%dx)
  100f9f:	66 c7 45 de f9 03    	movw   $0x3f9,-0x22(%ebp)
  100fa5:	c6 45 dd 01          	movb   $0x1,-0x23(%ebp)
  100fa9:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100fad:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  100fb1:	ee                   	out    %al,(%dx)
  100fb2:	66 c7 45 da fd 03    	movw   $0x3fd,-0x26(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fb8:	0f b7 45 da          	movzwl -0x26(%ebp),%eax
  100fbc:	89 c2                	mov    %eax,%edx
  100fbe:	ec                   	in     (%dx),%al
  100fbf:	88 45 d9             	mov    %al,-0x27(%ebp)
    return data;
  100fc2:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100fc6:	3c ff                	cmp    $0xff,%al
  100fc8:	0f 95 c0             	setne  %al
  100fcb:	0f b6 c0             	movzbl %al,%eax
  100fce:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  100fd3:	66 c7 45 d6 fa 03    	movw   $0x3fa,-0x2a(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100fd9:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
  100fdd:	89 c2                	mov    %eax,%edx
  100fdf:	ec                   	in     (%dx),%al
  100fe0:	88 45 d5             	mov    %al,-0x2b(%ebp)
  100fe3:	66 c7 45 d2 f8 03    	movw   $0x3f8,-0x2e(%ebp)
  100fe9:	0f b7 45 d2          	movzwl -0x2e(%ebp),%eax
  100fed:	89 c2                	mov    %eax,%edx
  100fef:	ec                   	in     (%dx),%al
  100ff0:	88 45 d1             	mov    %al,-0x2f(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  100ff3:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  100ff8:	85 c0                	test   %eax,%eax
  100ffa:	74 0c                	je     101008 <serial_init+0xe1>
        pic_enable(IRQ_COM1);
  100ffc:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
  101003:	e8 b0 06 00 00       	call   1016b8 <pic_enable>
    }
}
  101008:	c9                   	leave  
  101009:	c3                   	ret    

0010100a <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  10100a:	55                   	push   %ebp
  10100b:	89 e5                	mov    %esp,%ebp
  10100d:	83 ec 20             	sub    $0x20,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  101010:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101017:	eb 09                	jmp    101022 <lpt_putc_sub+0x18>
        delay();
  101019:	e8 db fd ff ff       	call   100df9 <delay>
}

static void
lpt_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  10101e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101022:	66 c7 45 fa 79 03    	movw   $0x379,-0x6(%ebp)
  101028:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10102c:	89 c2                	mov    %eax,%edx
  10102e:	ec                   	in     (%dx),%al
  10102f:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  101032:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101036:	84 c0                	test   %al,%al
  101038:	78 09                	js     101043 <lpt_putc_sub+0x39>
  10103a:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  101041:	7e d6                	jle    101019 <lpt_putc_sub+0xf>
        delay();
    }
    outb(LPTPORT + 0, c);
  101043:	8b 45 08             	mov    0x8(%ebp),%eax
  101046:	0f b6 c0             	movzbl %al,%eax
  101049:	66 c7 45 f6 78 03    	movw   $0x378,-0xa(%ebp)
  10104f:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101052:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  101056:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10105a:	ee                   	out    %al,(%dx)
  10105b:	66 c7 45 f2 7a 03    	movw   $0x37a,-0xe(%ebp)
  101061:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  101065:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101069:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10106d:	ee                   	out    %al,(%dx)
  10106e:	66 c7 45 ee 7a 03    	movw   $0x37a,-0x12(%ebp)
  101074:	c6 45 ed 08          	movb   $0x8,-0x13(%ebp)
  101078:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  10107c:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101080:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  101081:	c9                   	leave  
  101082:	c3                   	ret    

00101083 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  101083:	55                   	push   %ebp
  101084:	89 e5                	mov    %esp,%ebp
  101086:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  101089:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10108d:	74 0d                	je     10109c <lpt_putc+0x19>
        lpt_putc_sub(c);
  10108f:	8b 45 08             	mov    0x8(%ebp),%eax
  101092:	89 04 24             	mov    %eax,(%esp)
  101095:	e8 70 ff ff ff       	call   10100a <lpt_putc_sub>
  10109a:	eb 24                	jmp    1010c0 <lpt_putc+0x3d>
    }
    else {
        lpt_putc_sub('\b');
  10109c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010a3:	e8 62 ff ff ff       	call   10100a <lpt_putc_sub>
        lpt_putc_sub(' ');
  1010a8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  1010af:	e8 56 ff ff ff       	call   10100a <lpt_putc_sub>
        lpt_putc_sub('\b');
  1010b4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  1010bb:	e8 4a ff ff ff       	call   10100a <lpt_putc_sub>
    }
}
  1010c0:	c9                   	leave  
  1010c1:	c3                   	ret    

001010c2 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  1010c2:	55                   	push   %ebp
  1010c3:	89 e5                	mov    %esp,%ebp
  1010c5:	53                   	push   %ebx
  1010c6:	83 ec 34             	sub    $0x34,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  1010c9:	8b 45 08             	mov    0x8(%ebp),%eax
  1010cc:	b0 00                	mov    $0x0,%al
  1010ce:	85 c0                	test   %eax,%eax
  1010d0:	75 07                	jne    1010d9 <cga_putc+0x17>
        c |= 0x0700;
  1010d2:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  1010d9:	8b 45 08             	mov    0x8(%ebp),%eax
  1010dc:	0f b6 c0             	movzbl %al,%eax
  1010df:	83 f8 0a             	cmp    $0xa,%eax
  1010e2:	74 4c                	je     101130 <cga_putc+0x6e>
  1010e4:	83 f8 0d             	cmp    $0xd,%eax
  1010e7:	74 57                	je     101140 <cga_putc+0x7e>
  1010e9:	83 f8 08             	cmp    $0x8,%eax
  1010ec:	0f 85 88 00 00 00    	jne    10117a <cga_putc+0xb8>
    case '\b':
        if (crt_pos > 0) {
  1010f2:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010f9:	66 85 c0             	test   %ax,%ax
  1010fc:	74 30                	je     10112e <cga_putc+0x6c>
            crt_pos --;
  1010fe:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101105:	83 e8 01             	sub    $0x1,%eax
  101108:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  10110e:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101113:	0f b7 15 64 ee 10 00 	movzwl 0x10ee64,%edx
  10111a:	0f b7 d2             	movzwl %dx,%edx
  10111d:	01 d2                	add    %edx,%edx
  10111f:	01 c2                	add    %eax,%edx
  101121:	8b 45 08             	mov    0x8(%ebp),%eax
  101124:	b0 00                	mov    $0x0,%al
  101126:	83 c8 20             	or     $0x20,%eax
  101129:	66 89 02             	mov    %ax,(%edx)
        }
        break;
  10112c:	eb 72                	jmp    1011a0 <cga_putc+0xde>
  10112e:	eb 70                	jmp    1011a0 <cga_putc+0xde>
    case '\n':
        crt_pos += CRT_COLS;
  101130:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101137:	83 c0 50             	add    $0x50,%eax
  10113a:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  101140:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  101147:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  10114e:	0f b7 c1             	movzwl %cx,%eax
  101151:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  101157:	c1 e8 10             	shr    $0x10,%eax
  10115a:	89 c2                	mov    %eax,%edx
  10115c:	66 c1 ea 06          	shr    $0x6,%dx
  101160:	89 d0                	mov    %edx,%eax
  101162:	c1 e0 02             	shl    $0x2,%eax
  101165:	01 d0                	add    %edx,%eax
  101167:	c1 e0 04             	shl    $0x4,%eax
  10116a:	29 c1                	sub    %eax,%ecx
  10116c:	89 ca                	mov    %ecx,%edx
  10116e:	89 d8                	mov    %ebx,%eax
  101170:	29 d0                	sub    %edx,%eax
  101172:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  101178:	eb 26                	jmp    1011a0 <cga_putc+0xde>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  10117a:	8b 0d 60 ee 10 00    	mov    0x10ee60,%ecx
  101180:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101187:	8d 50 01             	lea    0x1(%eax),%edx
  10118a:	66 89 15 64 ee 10 00 	mov    %dx,0x10ee64
  101191:	0f b7 c0             	movzwl %ax,%eax
  101194:	01 c0                	add    %eax,%eax
  101196:	8d 14 01             	lea    (%ecx,%eax,1),%edx
  101199:	8b 45 08             	mov    0x8(%ebp),%eax
  10119c:	66 89 02             	mov    %ax,(%edx)
        break;
  10119f:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  1011a0:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011a7:	66 3d cf 07          	cmp    $0x7cf,%ax
  1011ab:	76 5b                	jbe    101208 <cga_putc+0x146>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  1011ad:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011b2:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  1011b8:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011bd:	c7 44 24 08 00 0f 00 	movl   $0xf00,0x8(%esp)
  1011c4:	00 
  1011c5:	89 54 24 04          	mov    %edx,0x4(%esp)
  1011c9:	89 04 24             	mov    %eax,(%esp)
  1011cc:	e8 ad 21 00 00       	call   10337e <memmove>
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1011d1:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  1011d8:	eb 15                	jmp    1011ef <cga_putc+0x12d>
            crt_buf[i] = 0x0700 | ' ';
  1011da:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1011df:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1011e2:	01 d2                	add    %edx,%edx
  1011e4:	01 d0                	add    %edx,%eax
  1011e6:	66 c7 00 20 07       	movw   $0x720,(%eax)

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  1011eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1011ef:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  1011f6:	7e e2                	jle    1011da <cga_putc+0x118>
            crt_buf[i] = 0x0700 | ' ';
        }
        crt_pos -= CRT_COLS;
  1011f8:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011ff:	83 e8 50             	sub    $0x50,%eax
  101202:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  101208:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  10120f:	0f b7 c0             	movzwl %ax,%eax
  101212:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  101216:	c6 45 f1 0e          	movb   $0xe,-0xf(%ebp)
  10121a:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10121e:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101222:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  101223:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10122a:	66 c1 e8 08          	shr    $0x8,%ax
  10122e:	0f b6 c0             	movzbl %al,%eax
  101231:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  101238:	83 c2 01             	add    $0x1,%edx
  10123b:	0f b7 d2             	movzwl %dx,%edx
  10123e:	66 89 55 ee          	mov    %dx,-0x12(%ebp)
  101242:	88 45 ed             	mov    %al,-0x13(%ebp)
  101245:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101249:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10124d:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  10124e:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  101255:	0f b7 c0             	movzwl %ax,%eax
  101258:	66 89 45 ea          	mov    %ax,-0x16(%ebp)
  10125c:	c6 45 e9 0f          	movb   $0xf,-0x17(%ebp)
  101260:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101264:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101268:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  101269:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101270:	0f b6 c0             	movzbl %al,%eax
  101273:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  10127a:	83 c2 01             	add    $0x1,%edx
  10127d:	0f b7 d2             	movzwl %dx,%edx
  101280:	66 89 55 e6          	mov    %dx,-0x1a(%ebp)
  101284:	88 45 e5             	mov    %al,-0x1b(%ebp)
  101287:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  10128b:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10128f:	ee                   	out    %al,(%dx)
}
  101290:	83 c4 34             	add    $0x34,%esp
  101293:	5b                   	pop    %ebx
  101294:	5d                   	pop    %ebp
  101295:	c3                   	ret    

00101296 <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  101296:	55                   	push   %ebp
  101297:	89 e5                	mov    %esp,%ebp
  101299:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  10129c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1012a3:	eb 09                	jmp    1012ae <serial_putc_sub+0x18>
        delay();
  1012a5:	e8 4f fb ff ff       	call   100df9 <delay>
}

static void
serial_putc_sub(int c) {
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  1012aa:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1012ae:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1012b4:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  1012b8:	89 c2                	mov    %eax,%edx
  1012ba:	ec                   	in     (%dx),%al
  1012bb:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  1012be:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1012c2:	0f b6 c0             	movzbl %al,%eax
  1012c5:	83 e0 20             	and    $0x20,%eax
  1012c8:	85 c0                	test   %eax,%eax
  1012ca:	75 09                	jne    1012d5 <serial_putc_sub+0x3f>
  1012cc:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  1012d3:	7e d0                	jle    1012a5 <serial_putc_sub+0xf>
        delay();
    }
    outb(COM1 + COM_TX, c);
  1012d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1012d8:	0f b6 c0             	movzbl %al,%eax
  1012db:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
  1012e1:	88 45 f5             	mov    %al,-0xb(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  1012e4:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  1012e8:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1012ec:	ee                   	out    %al,(%dx)
}
  1012ed:	c9                   	leave  
  1012ee:	c3                   	ret    

001012ef <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  1012ef:	55                   	push   %ebp
  1012f0:	89 e5                	mov    %esp,%ebp
  1012f2:	83 ec 04             	sub    $0x4,%esp
    if (c != '\b') {
  1012f5:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  1012f9:	74 0d                	je     101308 <serial_putc+0x19>
        serial_putc_sub(c);
  1012fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1012fe:	89 04 24             	mov    %eax,(%esp)
  101301:	e8 90 ff ff ff       	call   101296 <serial_putc_sub>
  101306:	eb 24                	jmp    10132c <serial_putc+0x3d>
    }
    else {
        serial_putc_sub('\b');
  101308:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  10130f:	e8 82 ff ff ff       	call   101296 <serial_putc_sub>
        serial_putc_sub(' ');
  101314:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  10131b:	e8 76 ff ff ff       	call   101296 <serial_putc_sub>
        serial_putc_sub('\b');
  101320:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
  101327:	e8 6a ff ff ff       	call   101296 <serial_putc_sub>
    }
}
  10132c:	c9                   	leave  
  10132d:	c3                   	ret    

0010132e <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  10132e:	55                   	push   %ebp
  10132f:	89 e5                	mov    %esp,%ebp
  101331:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  101334:	eb 33                	jmp    101369 <cons_intr+0x3b>
        if (c != 0) {
  101336:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10133a:	74 2d                	je     101369 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  10133c:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101341:	8d 50 01             	lea    0x1(%eax),%edx
  101344:	89 15 84 f0 10 00    	mov    %edx,0x10f084
  10134a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10134d:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  101353:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101358:	3d 00 02 00 00       	cmp    $0x200,%eax
  10135d:	75 0a                	jne    101369 <cons_intr+0x3b>
                cons.wpos = 0;
  10135f:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  101366:	00 00 00 
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
    int c;
    while ((c = (*proc)()) != -1) {
  101369:	8b 45 08             	mov    0x8(%ebp),%eax
  10136c:	ff d0                	call   *%eax
  10136e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101371:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101375:	75 bf                	jne    101336 <cons_intr+0x8>
            if (cons.wpos == CONSBUFSIZE) {
                cons.wpos = 0;
            }
        }
    }
}
  101377:	c9                   	leave  
  101378:	c3                   	ret    

00101379 <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  101379:	55                   	push   %ebp
  10137a:	89 e5                	mov    %esp,%ebp
  10137c:	83 ec 10             	sub    $0x10,%esp
  10137f:	66 c7 45 fa fd 03    	movw   $0x3fd,-0x6(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101385:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  101389:	89 c2                	mov    %eax,%edx
  10138b:	ec                   	in     (%dx),%al
  10138c:	88 45 f9             	mov    %al,-0x7(%ebp)
    return data;
  10138f:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101393:	0f b6 c0             	movzbl %al,%eax
  101396:	83 e0 01             	and    $0x1,%eax
  101399:	85 c0                	test   %eax,%eax
  10139b:	75 07                	jne    1013a4 <serial_proc_data+0x2b>
        return -1;
  10139d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1013a2:	eb 2a                	jmp    1013ce <serial_proc_data+0x55>
  1013a4:	66 c7 45 f6 f8 03    	movw   $0x3f8,-0xa(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013aa:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  1013ae:	89 c2                	mov    %eax,%edx
  1013b0:	ec                   	in     (%dx),%al
  1013b1:	88 45 f5             	mov    %al,-0xb(%ebp)
    return data;
  1013b4:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  1013b8:	0f b6 c0             	movzbl %al,%eax
  1013bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  1013be:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  1013c2:	75 07                	jne    1013cb <serial_proc_data+0x52>
        c = '\b';
  1013c4:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  1013cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1013ce:	c9                   	leave  
  1013cf:	c3                   	ret    

001013d0 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  1013d0:	55                   	push   %ebp
  1013d1:	89 e5                	mov    %esp,%ebp
  1013d3:	83 ec 18             	sub    $0x18,%esp
    if (serial_exists) {
  1013d6:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1013db:	85 c0                	test   %eax,%eax
  1013dd:	74 0c                	je     1013eb <serial_intr+0x1b>
        cons_intr(serial_proc_data);
  1013df:	c7 04 24 79 13 10 00 	movl   $0x101379,(%esp)
  1013e6:	e8 43 ff ff ff       	call   10132e <cons_intr>
    }
}
  1013eb:	c9                   	leave  
  1013ec:	c3                   	ret    

001013ed <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  1013ed:	55                   	push   %ebp
  1013ee:	89 e5                	mov    %esp,%ebp
  1013f0:	83 ec 38             	sub    $0x38,%esp
  1013f3:	66 c7 45 f0 64 00    	movw   $0x64,-0x10(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013f9:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1013fd:	89 c2                	mov    %eax,%edx
  1013ff:	ec                   	in     (%dx),%al
  101400:	88 45 ef             	mov    %al,-0x11(%ebp)
    return data;
  101403:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  101407:	0f b6 c0             	movzbl %al,%eax
  10140a:	83 e0 01             	and    $0x1,%eax
  10140d:	85 c0                	test   %eax,%eax
  10140f:	75 0a                	jne    10141b <kbd_proc_data+0x2e>
        return -1;
  101411:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101416:	e9 59 01 00 00       	jmp    101574 <kbd_proc_data+0x187>
  10141b:	66 c7 45 ec 60 00    	movw   $0x60,-0x14(%ebp)
static inline void ltr(uint16_t sel) __attribute__((always_inline));

static inline uint8_t
inb(uint16_t port) {
    uint8_t data;
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101421:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101425:	89 c2                	mov    %eax,%edx
  101427:	ec                   	in     (%dx),%al
  101428:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  10142b:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    }

    data = inb(KBDATAP);
  10142f:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  101432:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  101436:	75 17                	jne    10144f <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  101438:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10143d:	83 c8 40             	or     $0x40,%eax
  101440:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101445:	b8 00 00 00 00       	mov    $0x0,%eax
  10144a:	e9 25 01 00 00       	jmp    101574 <kbd_proc_data+0x187>
    } else if (data & 0x80) {
  10144f:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101453:	84 c0                	test   %al,%al
  101455:	79 47                	jns    10149e <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  101457:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10145c:	83 e0 40             	and    $0x40,%eax
  10145f:	85 c0                	test   %eax,%eax
  101461:	75 09                	jne    10146c <kbd_proc_data+0x7f>
  101463:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101467:	83 e0 7f             	and    $0x7f,%eax
  10146a:	eb 04                	jmp    101470 <kbd_proc_data+0x83>
  10146c:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101470:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101473:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101477:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  10147e:	83 c8 40             	or     $0x40,%eax
  101481:	0f b6 c0             	movzbl %al,%eax
  101484:	f7 d0                	not    %eax
  101486:	89 c2                	mov    %eax,%edx
  101488:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10148d:	21 d0                	and    %edx,%eax
  10148f:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  101494:	b8 00 00 00 00       	mov    $0x0,%eax
  101499:	e9 d6 00 00 00       	jmp    101574 <kbd_proc_data+0x187>
    } else if (shift & E0ESC) {
  10149e:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014a3:	83 e0 40             	and    $0x40,%eax
  1014a6:	85 c0                	test   %eax,%eax
  1014a8:	74 11                	je     1014bb <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  1014aa:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  1014ae:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014b3:	83 e0 bf             	and    $0xffffffbf,%eax
  1014b6:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  1014bb:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014bf:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  1014c6:	0f b6 d0             	movzbl %al,%edx
  1014c9:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014ce:	09 d0                	or     %edx,%eax
  1014d0:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  1014d5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1014d9:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  1014e0:	0f b6 d0             	movzbl %al,%edx
  1014e3:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014e8:	31 d0                	xor    %edx,%eax
  1014ea:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  1014ef:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014f4:	83 e0 03             	and    $0x3,%eax
  1014f7:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  1014fe:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101502:	01 d0                	add    %edx,%eax
  101504:	0f b6 00             	movzbl (%eax),%eax
  101507:	0f b6 c0             	movzbl %al,%eax
  10150a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  10150d:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101512:	83 e0 08             	and    $0x8,%eax
  101515:	85 c0                	test   %eax,%eax
  101517:	74 22                	je     10153b <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  101519:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  10151d:	7e 0c                	jle    10152b <kbd_proc_data+0x13e>
  10151f:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  101523:	7f 06                	jg     10152b <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  101525:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  101529:	eb 10                	jmp    10153b <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  10152b:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  10152f:	7e 0a                	jle    10153b <kbd_proc_data+0x14e>
  101531:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  101535:	7f 04                	jg     10153b <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  101537:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  10153b:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101540:	f7 d0                	not    %eax
  101542:	83 e0 06             	and    $0x6,%eax
  101545:	85 c0                	test   %eax,%eax
  101547:	75 28                	jne    101571 <kbd_proc_data+0x184>
  101549:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  101550:	75 1f                	jne    101571 <kbd_proc_data+0x184>
        cprintf("Rebooting!\n");
  101552:	c7 04 24 11 38 10 00 	movl   $0x103811,(%esp)
  101559:	e8 b4 ed ff ff       	call   100312 <cprintf>
  10155e:	66 c7 45 e8 92 00    	movw   $0x92,-0x18(%ebp)
  101564:	c6 45 e7 03          	movb   $0x3,-0x19(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101568:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  10156c:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  101570:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  101571:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  101574:	c9                   	leave  
  101575:	c3                   	ret    

00101576 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101576:	55                   	push   %ebp
  101577:	89 e5                	mov    %esp,%ebp
  101579:	83 ec 18             	sub    $0x18,%esp
    cons_intr(kbd_proc_data);
  10157c:	c7 04 24 ed 13 10 00 	movl   $0x1013ed,(%esp)
  101583:	e8 a6 fd ff ff       	call   10132e <cons_intr>
}
  101588:	c9                   	leave  
  101589:	c3                   	ret    

0010158a <kbd_init>:

static void
kbd_init(void) {
  10158a:	55                   	push   %ebp
  10158b:	89 e5                	mov    %esp,%ebp
  10158d:	83 ec 18             	sub    $0x18,%esp
    // drain the kbd buffer
    kbd_intr();
  101590:	e8 e1 ff ff ff       	call   101576 <kbd_intr>
    pic_enable(IRQ_KBD);
  101595:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  10159c:	e8 17 01 00 00       	call   1016b8 <pic_enable>
}
  1015a1:	c9                   	leave  
  1015a2:	c3                   	ret    

001015a3 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  1015a3:	55                   	push   %ebp
  1015a4:	89 e5                	mov    %esp,%ebp
  1015a6:	83 ec 18             	sub    $0x18,%esp
    cga_init();
  1015a9:	e8 93 f8 ff ff       	call   100e41 <cga_init>
    serial_init();
  1015ae:	e8 74 f9 ff ff       	call   100f27 <serial_init>
    kbd_init();
  1015b3:	e8 d2 ff ff ff       	call   10158a <kbd_init>
    if (!serial_exists) {
  1015b8:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  1015bd:	85 c0                	test   %eax,%eax
  1015bf:	75 0c                	jne    1015cd <cons_init+0x2a>
        cprintf("serial port does not exist!!\n");
  1015c1:	c7 04 24 1d 38 10 00 	movl   $0x10381d,(%esp)
  1015c8:	e8 45 ed ff ff       	call   100312 <cprintf>
    }
}
  1015cd:	c9                   	leave  
  1015ce:	c3                   	ret    

001015cf <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  1015cf:	55                   	push   %ebp
  1015d0:	89 e5                	mov    %esp,%ebp
  1015d2:	83 ec 18             	sub    $0x18,%esp
    lpt_putc(c);
  1015d5:	8b 45 08             	mov    0x8(%ebp),%eax
  1015d8:	89 04 24             	mov    %eax,(%esp)
  1015db:	e8 a3 fa ff ff       	call   101083 <lpt_putc>
    cga_putc(c);
  1015e0:	8b 45 08             	mov    0x8(%ebp),%eax
  1015e3:	89 04 24             	mov    %eax,(%esp)
  1015e6:	e8 d7 fa ff ff       	call   1010c2 <cga_putc>
    serial_putc(c);
  1015eb:	8b 45 08             	mov    0x8(%ebp),%eax
  1015ee:	89 04 24             	mov    %eax,(%esp)
  1015f1:	e8 f9 fc ff ff       	call   1012ef <serial_putc>
}
  1015f6:	c9                   	leave  
  1015f7:	c3                   	ret    

001015f8 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1015f8:	55                   	push   %ebp
  1015f9:	89 e5                	mov    %esp,%ebp
  1015fb:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1015fe:	e8 cd fd ff ff       	call   1013d0 <serial_intr>
    kbd_intr();
  101603:	e8 6e ff ff ff       	call   101576 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  101608:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  10160e:	a1 84 f0 10 00       	mov    0x10f084,%eax
  101613:	39 c2                	cmp    %eax,%edx
  101615:	74 36                	je     10164d <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  101617:	a1 80 f0 10 00       	mov    0x10f080,%eax
  10161c:	8d 50 01             	lea    0x1(%eax),%edx
  10161f:	89 15 80 f0 10 00    	mov    %edx,0x10f080
  101625:	0f b6 80 80 ee 10 00 	movzbl 0x10ee80(%eax),%eax
  10162c:	0f b6 c0             	movzbl %al,%eax
  10162f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  101632:	a1 80 f0 10 00       	mov    0x10f080,%eax
  101637:	3d 00 02 00 00       	cmp    $0x200,%eax
  10163c:	75 0a                	jne    101648 <cons_getc+0x50>
            cons.rpos = 0;
  10163e:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  101645:	00 00 00 
        }
        return c;
  101648:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10164b:	eb 05                	jmp    101652 <cons_getc+0x5a>
    }
    return 0;
  10164d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  101652:	c9                   	leave  
  101653:	c3                   	ret    

00101654 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  101654:	55                   	push   %ebp
  101655:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  101657:	fb                   	sti    
    sti();
}
  101658:	5d                   	pop    %ebp
  101659:	c3                   	ret    

0010165a <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  10165a:	55                   	push   %ebp
  10165b:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  10165d:	fa                   	cli    
    cli();
}
  10165e:	5d                   	pop    %ebp
  10165f:	c3                   	ret    

00101660 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101660:	55                   	push   %ebp
  101661:	89 e5                	mov    %esp,%ebp
  101663:	83 ec 14             	sub    $0x14,%esp
  101666:	8b 45 08             	mov    0x8(%ebp),%eax
  101669:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  10166d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101671:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  101677:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  10167c:	85 c0                	test   %eax,%eax
  10167e:	74 36                	je     1016b6 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  101680:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101684:	0f b6 c0             	movzbl %al,%eax
  101687:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  10168d:	88 45 fd             	mov    %al,-0x3(%ebp)
            : "memory", "cc");
}

static inline void
outb(uint16_t port, uint8_t data) {
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101690:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101694:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101698:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  101699:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10169d:	66 c1 e8 08          	shr    $0x8,%ax
  1016a1:	0f b6 c0             	movzbl %al,%eax
  1016a4:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  1016aa:	88 45 f9             	mov    %al,-0x7(%ebp)
  1016ad:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  1016b1:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1016b5:	ee                   	out    %al,(%dx)
    }
}
  1016b6:	c9                   	leave  
  1016b7:	c3                   	ret    

001016b8 <pic_enable>:

void
pic_enable(unsigned int irq) {
  1016b8:	55                   	push   %ebp
  1016b9:	89 e5                	mov    %esp,%ebp
  1016bb:	83 ec 04             	sub    $0x4,%esp
    pic_setmask(irq_mask & ~(1 << irq));
  1016be:	8b 45 08             	mov    0x8(%ebp),%eax
  1016c1:	ba 01 00 00 00       	mov    $0x1,%edx
  1016c6:	89 c1                	mov    %eax,%ecx
  1016c8:	d3 e2                	shl    %cl,%edx
  1016ca:	89 d0                	mov    %edx,%eax
  1016cc:	f7 d0                	not    %eax
  1016ce:	89 c2                	mov    %eax,%edx
  1016d0:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1016d7:	21 d0                	and    %edx,%eax
  1016d9:	0f b7 c0             	movzwl %ax,%eax
  1016dc:	89 04 24             	mov    %eax,(%esp)
  1016df:	e8 7c ff ff ff       	call   101660 <pic_setmask>
}
  1016e4:	c9                   	leave  
  1016e5:	c3                   	ret    

001016e6 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  1016e6:	55                   	push   %ebp
  1016e7:	89 e5                	mov    %esp,%ebp
  1016e9:	83 ec 44             	sub    $0x44,%esp
    did_init = 1;
  1016ec:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  1016f3:	00 00 00 
  1016f6:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  1016fc:	c6 45 fd ff          	movb   $0xff,-0x3(%ebp)
  101700:	0f b6 45 fd          	movzbl -0x3(%ebp),%eax
  101704:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101708:	ee                   	out    %al,(%dx)
  101709:	66 c7 45 fa a1 00    	movw   $0xa1,-0x6(%ebp)
  10170f:	c6 45 f9 ff          	movb   $0xff,-0x7(%ebp)
  101713:	0f b6 45 f9          	movzbl -0x7(%ebp),%eax
  101717:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10171b:	ee                   	out    %al,(%dx)
  10171c:	66 c7 45 f6 20 00    	movw   $0x20,-0xa(%ebp)
  101722:	c6 45 f5 11          	movb   $0x11,-0xb(%ebp)
  101726:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
  10172a:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10172e:	ee                   	out    %al,(%dx)
  10172f:	66 c7 45 f2 21 00    	movw   $0x21,-0xe(%ebp)
  101735:	c6 45 f1 20          	movb   $0x20,-0xf(%ebp)
  101739:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  10173d:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  101741:	ee                   	out    %al,(%dx)
  101742:	66 c7 45 ee 21 00    	movw   $0x21,-0x12(%ebp)
  101748:	c6 45 ed 04          	movb   $0x4,-0x13(%ebp)
  10174c:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  101750:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101754:	ee                   	out    %al,(%dx)
  101755:	66 c7 45 ea 21 00    	movw   $0x21,-0x16(%ebp)
  10175b:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
  10175f:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101763:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101767:	ee                   	out    %al,(%dx)
  101768:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  10176e:	c6 45 e5 11          	movb   $0x11,-0x1b(%ebp)
  101772:	0f b6 45 e5          	movzbl -0x1b(%ebp),%eax
  101776:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10177a:	ee                   	out    %al,(%dx)
  10177b:	66 c7 45 e2 a1 00    	movw   $0xa1,-0x1e(%ebp)
  101781:	c6 45 e1 28          	movb   $0x28,-0x1f(%ebp)
  101785:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101789:	0f b7 55 e2          	movzwl -0x1e(%ebp),%edx
  10178d:	ee                   	out    %al,(%dx)
  10178e:	66 c7 45 de a1 00    	movw   $0xa1,-0x22(%ebp)
  101794:	c6 45 dd 02          	movb   $0x2,-0x23(%ebp)
  101798:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10179c:	0f b7 55 de          	movzwl -0x22(%ebp),%edx
  1017a0:	ee                   	out    %al,(%dx)
  1017a1:	66 c7 45 da a1 00    	movw   $0xa1,-0x26(%ebp)
  1017a7:	c6 45 d9 03          	movb   $0x3,-0x27(%ebp)
  1017ab:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  1017af:	0f b7 55 da          	movzwl -0x26(%ebp),%edx
  1017b3:	ee                   	out    %al,(%dx)
  1017b4:	66 c7 45 d6 20 00    	movw   $0x20,-0x2a(%ebp)
  1017ba:	c6 45 d5 68          	movb   $0x68,-0x2b(%ebp)
  1017be:	0f b6 45 d5          	movzbl -0x2b(%ebp),%eax
  1017c2:	0f b7 55 d6          	movzwl -0x2a(%ebp),%edx
  1017c6:	ee                   	out    %al,(%dx)
  1017c7:	66 c7 45 d2 20 00    	movw   $0x20,-0x2e(%ebp)
  1017cd:	c6 45 d1 0a          	movb   $0xa,-0x2f(%ebp)
  1017d1:	0f b6 45 d1          	movzbl -0x2f(%ebp),%eax
  1017d5:	0f b7 55 d2          	movzwl -0x2e(%ebp),%edx
  1017d9:	ee                   	out    %al,(%dx)
  1017da:	66 c7 45 ce a0 00    	movw   $0xa0,-0x32(%ebp)
  1017e0:	c6 45 cd 68          	movb   $0x68,-0x33(%ebp)
  1017e4:	0f b6 45 cd          	movzbl -0x33(%ebp),%eax
  1017e8:	0f b7 55 ce          	movzwl -0x32(%ebp),%edx
  1017ec:	ee                   	out    %al,(%dx)
  1017ed:	66 c7 45 ca a0 00    	movw   $0xa0,-0x36(%ebp)
  1017f3:	c6 45 c9 0a          	movb   $0xa,-0x37(%ebp)
  1017f7:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
  1017fb:	0f b7 55 ca          	movzwl -0x36(%ebp),%edx
  1017ff:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  101800:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101807:	66 83 f8 ff          	cmp    $0xffff,%ax
  10180b:	74 12                	je     10181f <pic_init+0x139>
        pic_setmask(irq_mask);
  10180d:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101814:	0f b7 c0             	movzwl %ax,%eax
  101817:	89 04 24             	mov    %eax,(%esp)
  10181a:	e8 41 fe ff ff       	call   101660 <pic_setmask>
    }
}
  10181f:	c9                   	leave  
  101820:	c3                   	ret    

00101821 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  101821:	55                   	push   %ebp
  101822:	89 e5                	mov    %esp,%ebp
  101824:	83 ec 18             	sub    $0x18,%esp
    cprintf("%d ticks\n",TICK_NUM);
  101827:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
  10182e:	00 
  10182f:	c7 04 24 40 38 10 00 	movl   $0x103840,(%esp)
  101836:	e8 d7 ea ff ff       	call   100312 <cprintf>
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
  10183b:	c7 04 24 4a 38 10 00 	movl   $0x10384a,(%esp)
  101842:	e8 cb ea ff ff       	call   100312 <cprintf>
    panic("EOT: kernel seems ok.");
  101847:	c7 44 24 08 58 38 10 	movl   $0x103858,0x8(%esp)
  10184e:	00 
  10184f:	c7 44 24 04 12 00 00 	movl   $0x12,0x4(%esp)
  101856:	00 
  101857:	c7 04 24 6e 38 10 00 	movl   $0x10386e,(%esp)
  10185e:	e8 77 f4 ff ff       	call   100cda <__panic>

00101863 <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  101863:	55                   	push   %ebp
  101864:	89 e5                	mov    %esp,%ebp
  101866:	83 ec 10             	sub    $0x10,%esp
      *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	extern uintptr_t __vectors[];

	int i=0, num=sizeof(idt)/sizeof(idt[0]);
  101869:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  101870:	c7 45 f8 00 01 00 00 	movl   $0x100,-0x8(%ebp)
	for (; i<num; ++i)
  101877:	e9 c3 00 00 00       	jmp    10193f <idt_init+0xdc>
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);
  10187c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10187f:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  101886:	89 c2                	mov    %eax,%edx
  101888:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10188b:	66 89 14 c5 a0 f0 10 	mov    %dx,0x10f0a0(,%eax,8)
  101892:	00 
  101893:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101896:	66 c7 04 c5 a2 f0 10 	movw   $0x8,0x10f0a2(,%eax,8)
  10189d:	00 08 00 
  1018a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018a3:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  1018aa:	00 
  1018ab:	83 e2 e0             	and    $0xffffffe0,%edx
  1018ae:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  1018b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018b8:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  1018bf:	00 
  1018c0:	83 e2 1f             	and    $0x1f,%edx
  1018c3:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  1018ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018cd:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018d4:	00 
  1018d5:	83 e2 f0             	and    $0xfffffff0,%edx
  1018d8:	83 ca 0e             	or     $0xe,%edx
  1018db:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018e5:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  1018ec:	00 
  1018ed:	83 e2 ef             	and    $0xffffffef,%edx
  1018f0:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018fa:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101901:	00 
  101902:	83 e2 9f             	and    $0xffffff9f,%edx
  101905:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  10190c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10190f:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101916:	00 
  101917:	83 ca 80             	or     $0xffffff80,%edx
  10191a:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101921:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101924:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  10192b:	c1 e8 10             	shr    $0x10,%eax
  10192e:	89 c2                	mov    %eax,%edx
  101930:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101933:	66 89 14 c5 a6 f0 10 	mov    %dx,0x10f0a6(,%eax,8)
  10193a:	00 
      *     Notice: the argument of lidt is idt_pd. try to find it!
      */
	extern uintptr_t __vectors[];

	int i=0, num=sizeof(idt)/sizeof(idt[0]);
	for (; i<num; ++i)
  10193b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  10193f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101942:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  101945:	0f 8c 31 ff ff ff    	jl     10187c <idt_init+0x19>
		SETGATE(idt[i], 0, GD_KTEXT, __vectors[i], DPL_KERNEL);

	SETGATE(idt[T_SWITCH_TOK], 0, GD_KTEXT, __vectors[T_SWITCH_TOK], DPL_USER);
  10194b:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  101950:	66 a3 68 f4 10 00    	mov    %ax,0x10f468
  101956:	66 c7 05 6a f4 10 00 	movw   $0x8,0x10f46a
  10195d:	08 00 
  10195f:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101966:	83 e0 e0             	and    $0xffffffe0,%eax
  101969:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10196e:	0f b6 05 6c f4 10 00 	movzbl 0x10f46c,%eax
  101975:	83 e0 1f             	and    $0x1f,%eax
  101978:	a2 6c f4 10 00       	mov    %al,0x10f46c
  10197d:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101984:	83 e0 f0             	and    $0xfffffff0,%eax
  101987:	83 c8 0e             	or     $0xe,%eax
  10198a:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10198f:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  101996:	83 e0 ef             	and    $0xffffffef,%eax
  101999:	a2 6d f4 10 00       	mov    %al,0x10f46d
  10199e:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  1019a5:	83 c8 60             	or     $0x60,%eax
  1019a8:	a2 6d f4 10 00       	mov    %al,0x10f46d
  1019ad:	0f b6 05 6d f4 10 00 	movzbl 0x10f46d,%eax
  1019b4:	83 c8 80             	or     $0xffffff80,%eax
  1019b7:	a2 6d f4 10 00       	mov    %al,0x10f46d
  1019bc:	a1 c4 e7 10 00       	mov    0x10e7c4,%eax
  1019c1:	c1 e8 10             	shr    $0x10,%eax
  1019c4:	66 a3 6e f4 10 00    	mov    %ax,0x10f46e
  1019ca:	c7 45 f4 60 e5 10 00 	movl   $0x10e560,-0xc(%ebp)
    return ebp;
}

static inline void
lidt(struct pseudodesc *pd) {
    asm volatile ("lidt (%0)" :: "r" (pd));
  1019d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1019d4:	0f 01 18             	lidtl  (%eax)

	lidt(&idt_pd);
}
  1019d7:	c9                   	leave  
  1019d8:	c3                   	ret    

001019d9 <trapname>:

static const char *
trapname(int trapno) {
  1019d9:	55                   	push   %ebp
  1019da:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  1019dc:	8b 45 08             	mov    0x8(%ebp),%eax
  1019df:	83 f8 13             	cmp    $0x13,%eax
  1019e2:	77 0c                	ja     1019f0 <trapname+0x17>
        return excnames[trapno];
  1019e4:	8b 45 08             	mov    0x8(%ebp),%eax
  1019e7:	8b 04 85 c0 3b 10 00 	mov    0x103bc0(,%eax,4),%eax
  1019ee:	eb 18                	jmp    101a08 <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  1019f0:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  1019f4:	7e 0d                	jle    101a03 <trapname+0x2a>
  1019f6:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  1019fa:	7f 07                	jg     101a03 <trapname+0x2a>
        return "Hardware Interrupt";
  1019fc:	b8 7f 38 10 00       	mov    $0x10387f,%eax
  101a01:	eb 05                	jmp    101a08 <trapname+0x2f>
    }
    return "(unknown trap)";
  101a03:	b8 92 38 10 00       	mov    $0x103892,%eax
}
  101a08:	5d                   	pop    %ebp
  101a09:	c3                   	ret    

00101a0a <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  101a0a:	55                   	push   %ebp
  101a0b:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  101a0d:	8b 45 08             	mov    0x8(%ebp),%eax
  101a10:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101a14:	66 83 f8 08          	cmp    $0x8,%ax
  101a18:	0f 94 c0             	sete   %al
  101a1b:	0f b6 c0             	movzbl %al,%eax
}
  101a1e:	5d                   	pop    %ebp
  101a1f:	c3                   	ret    

00101a20 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  101a20:	55                   	push   %ebp
  101a21:	89 e5                	mov    %esp,%ebp
  101a23:	83 ec 28             	sub    $0x28,%esp
    cprintf("trapframe at %p\n", tf);
  101a26:	8b 45 08             	mov    0x8(%ebp),%eax
  101a29:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a2d:	c7 04 24 d3 38 10 00 	movl   $0x1038d3,(%esp)
  101a34:	e8 d9 e8 ff ff       	call   100312 <cprintf>
    print_regs(&tf->tf_regs);
  101a39:	8b 45 08             	mov    0x8(%ebp),%eax
  101a3c:	89 04 24             	mov    %eax,(%esp)
  101a3f:	e8 a1 01 00 00       	call   101be5 <print_regs>
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  101a44:	8b 45 08             	mov    0x8(%ebp),%eax
  101a47:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  101a4b:	0f b7 c0             	movzwl %ax,%eax
  101a4e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a52:	c7 04 24 e4 38 10 00 	movl   $0x1038e4,(%esp)
  101a59:	e8 b4 e8 ff ff       	call   100312 <cprintf>
    cprintf("  es   0x----%04x\n", tf->tf_es);
  101a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  101a61:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  101a65:	0f b7 c0             	movzwl %ax,%eax
  101a68:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a6c:	c7 04 24 f7 38 10 00 	movl   $0x1038f7,(%esp)
  101a73:	e8 9a e8 ff ff       	call   100312 <cprintf>
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101a78:	8b 45 08             	mov    0x8(%ebp),%eax
  101a7b:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101a7f:	0f b7 c0             	movzwl %ax,%eax
  101a82:	89 44 24 04          	mov    %eax,0x4(%esp)
  101a86:	c7 04 24 0a 39 10 00 	movl   $0x10390a,(%esp)
  101a8d:	e8 80 e8 ff ff       	call   100312 <cprintf>
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101a92:	8b 45 08             	mov    0x8(%ebp),%eax
  101a95:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101a99:	0f b7 c0             	movzwl %ax,%eax
  101a9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101aa0:	c7 04 24 1d 39 10 00 	movl   $0x10391d,(%esp)
  101aa7:	e8 66 e8 ff ff       	call   100312 <cprintf>
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101aac:	8b 45 08             	mov    0x8(%ebp),%eax
  101aaf:	8b 40 30             	mov    0x30(%eax),%eax
  101ab2:	89 04 24             	mov    %eax,(%esp)
  101ab5:	e8 1f ff ff ff       	call   1019d9 <trapname>
  101aba:	8b 55 08             	mov    0x8(%ebp),%edx
  101abd:	8b 52 30             	mov    0x30(%edx),%edx
  101ac0:	89 44 24 08          	mov    %eax,0x8(%esp)
  101ac4:	89 54 24 04          	mov    %edx,0x4(%esp)
  101ac8:	c7 04 24 30 39 10 00 	movl   $0x103930,(%esp)
  101acf:	e8 3e e8 ff ff       	call   100312 <cprintf>
    cprintf("  err  0x%08x\n", tf->tf_err);
  101ad4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad7:	8b 40 34             	mov    0x34(%eax),%eax
  101ada:	89 44 24 04          	mov    %eax,0x4(%esp)
  101ade:	c7 04 24 42 39 10 00 	movl   $0x103942,(%esp)
  101ae5:	e8 28 e8 ff ff       	call   100312 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101aea:	8b 45 08             	mov    0x8(%ebp),%eax
  101aed:	8b 40 38             	mov    0x38(%eax),%eax
  101af0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101af4:	c7 04 24 51 39 10 00 	movl   $0x103951,(%esp)
  101afb:	e8 12 e8 ff ff       	call   100312 <cprintf>
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101b00:	8b 45 08             	mov    0x8(%ebp),%eax
  101b03:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101b07:	0f b7 c0             	movzwl %ax,%eax
  101b0a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b0e:	c7 04 24 60 39 10 00 	movl   $0x103960,(%esp)
  101b15:	e8 f8 e7 ff ff       	call   100312 <cprintf>
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b1d:	8b 40 40             	mov    0x40(%eax),%eax
  101b20:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b24:	c7 04 24 73 39 10 00 	movl   $0x103973,(%esp)
  101b2b:	e8 e2 e7 ff ff       	call   100312 <cprintf>

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b30:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101b37:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101b3e:	eb 3e                	jmp    101b7e <print_trapframe+0x15e>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101b40:	8b 45 08             	mov    0x8(%ebp),%eax
  101b43:	8b 50 40             	mov    0x40(%eax),%edx
  101b46:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101b49:	21 d0                	and    %edx,%eax
  101b4b:	85 c0                	test   %eax,%eax
  101b4d:	74 28                	je     101b77 <print_trapframe+0x157>
  101b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b52:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b59:	85 c0                	test   %eax,%eax
  101b5b:	74 1a                	je     101b77 <print_trapframe+0x157>
            cprintf("%s,", IA32flags[i]);
  101b5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b60:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101b67:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b6b:	c7 04 24 82 39 10 00 	movl   $0x103982,(%esp)
  101b72:	e8 9b e7 ff ff       	call   100312 <cprintf>
    cprintf("  eip  0x%08x\n", tf->tf_eip);
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
    cprintf("  flag 0x%08x ", tf->tf_eflags);

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b77:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101b7b:	d1 65 f0             	shll   -0x10(%ebp)
  101b7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b81:	83 f8 17             	cmp    $0x17,%eax
  101b84:	76 ba                	jbe    101b40 <print_trapframe+0x120>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
            cprintf("%s,", IA32flags[i]);
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101b86:	8b 45 08             	mov    0x8(%ebp),%eax
  101b89:	8b 40 40             	mov    0x40(%eax),%eax
  101b8c:	25 00 30 00 00       	and    $0x3000,%eax
  101b91:	c1 e8 0c             	shr    $0xc,%eax
  101b94:	89 44 24 04          	mov    %eax,0x4(%esp)
  101b98:	c7 04 24 86 39 10 00 	movl   $0x103986,(%esp)
  101b9f:	e8 6e e7 ff ff       	call   100312 <cprintf>

    if (!trap_in_kernel(tf)) {
  101ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  101ba7:	89 04 24             	mov    %eax,(%esp)
  101baa:	e8 5b fe ff ff       	call   101a0a <trap_in_kernel>
  101baf:	85 c0                	test   %eax,%eax
  101bb1:	75 30                	jne    101be3 <print_trapframe+0x1c3>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101bb3:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb6:	8b 40 44             	mov    0x44(%eax),%eax
  101bb9:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bbd:	c7 04 24 8f 39 10 00 	movl   $0x10398f,(%esp)
  101bc4:	e8 49 e7 ff ff       	call   100312 <cprintf>
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  101bcc:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101bd0:	0f b7 c0             	movzwl %ax,%eax
  101bd3:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bd7:	c7 04 24 9e 39 10 00 	movl   $0x10399e,(%esp)
  101bde:	e8 2f e7 ff ff       	call   100312 <cprintf>
    }
}
  101be3:	c9                   	leave  
  101be4:	c3                   	ret    

00101be5 <print_regs>:

void
print_regs(struct pushregs *regs) {
  101be5:	55                   	push   %ebp
  101be6:	89 e5                	mov    %esp,%ebp
  101be8:	83 ec 18             	sub    $0x18,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101beb:	8b 45 08             	mov    0x8(%ebp),%eax
  101bee:	8b 00                	mov    (%eax),%eax
  101bf0:	89 44 24 04          	mov    %eax,0x4(%esp)
  101bf4:	c7 04 24 b1 39 10 00 	movl   $0x1039b1,(%esp)
  101bfb:	e8 12 e7 ff ff       	call   100312 <cprintf>
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101c00:	8b 45 08             	mov    0x8(%ebp),%eax
  101c03:	8b 40 04             	mov    0x4(%eax),%eax
  101c06:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c0a:	c7 04 24 c0 39 10 00 	movl   $0x1039c0,(%esp)
  101c11:	e8 fc e6 ff ff       	call   100312 <cprintf>
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101c16:	8b 45 08             	mov    0x8(%ebp),%eax
  101c19:	8b 40 08             	mov    0x8(%eax),%eax
  101c1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c20:	c7 04 24 cf 39 10 00 	movl   $0x1039cf,(%esp)
  101c27:	e8 e6 e6 ff ff       	call   100312 <cprintf>
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101c2c:	8b 45 08             	mov    0x8(%ebp),%eax
  101c2f:	8b 40 0c             	mov    0xc(%eax),%eax
  101c32:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c36:	c7 04 24 de 39 10 00 	movl   $0x1039de,(%esp)
  101c3d:	e8 d0 e6 ff ff       	call   100312 <cprintf>
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101c42:	8b 45 08             	mov    0x8(%ebp),%eax
  101c45:	8b 40 10             	mov    0x10(%eax),%eax
  101c48:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c4c:	c7 04 24 ed 39 10 00 	movl   $0x1039ed,(%esp)
  101c53:	e8 ba e6 ff ff       	call   100312 <cprintf>
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101c58:	8b 45 08             	mov    0x8(%ebp),%eax
  101c5b:	8b 40 14             	mov    0x14(%eax),%eax
  101c5e:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c62:	c7 04 24 fc 39 10 00 	movl   $0x1039fc,(%esp)
  101c69:	e8 a4 e6 ff ff       	call   100312 <cprintf>
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101c6e:	8b 45 08             	mov    0x8(%ebp),%eax
  101c71:	8b 40 18             	mov    0x18(%eax),%eax
  101c74:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c78:	c7 04 24 0b 3a 10 00 	movl   $0x103a0b,(%esp)
  101c7f:	e8 8e e6 ff ff       	call   100312 <cprintf>
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101c84:	8b 45 08             	mov    0x8(%ebp),%eax
  101c87:	8b 40 1c             	mov    0x1c(%eax),%eax
  101c8a:	89 44 24 04          	mov    %eax,0x4(%esp)
  101c8e:	c7 04 24 1a 3a 10 00 	movl   $0x103a1a,(%esp)
  101c95:	e8 78 e6 ff ff       	call   100312 <cprintf>
}
  101c9a:	c9                   	leave  
  101c9b:	c3                   	ret    

00101c9c <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101c9c:	55                   	push   %ebp
  101c9d:	89 e5                	mov    %esp,%ebp
  101c9f:	83 ec 28             	sub    $0x28,%esp
    char c;

    switch (tf->tf_trapno) {
  101ca2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ca5:	8b 40 30             	mov    0x30(%eax),%eax
  101ca8:	83 f8 2f             	cmp    $0x2f,%eax
  101cab:	77 1d                	ja     101cca <trap_dispatch+0x2e>
  101cad:	83 f8 2e             	cmp    $0x2e,%eax
  101cb0:	0f 83 f2 00 00 00    	jae    101da8 <trap_dispatch+0x10c>
  101cb6:	83 f8 21             	cmp    $0x21,%eax
  101cb9:	74 73                	je     101d2e <trap_dispatch+0x92>
  101cbb:	83 f8 24             	cmp    $0x24,%eax
  101cbe:	74 48                	je     101d08 <trap_dispatch+0x6c>
  101cc0:	83 f8 20             	cmp    $0x20,%eax
  101cc3:	74 13                	je     101cd8 <trap_dispatch+0x3c>
  101cc5:	e9 a6 00 00 00       	jmp    101d70 <trap_dispatch+0xd4>
  101cca:	83 e8 78             	sub    $0x78,%eax
  101ccd:	83 f8 01             	cmp    $0x1,%eax
  101cd0:	0f 87 9a 00 00 00    	ja     101d70 <trap_dispatch+0xd4>
  101cd6:	eb 7c                	jmp    101d54 <trap_dispatch+0xb8>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
    	ticks++;
  101cd8:	a1 08 f9 10 00       	mov    0x10f908,%eax
  101cdd:	83 c0 01             	add    $0x1,%eax
  101ce0:	a3 08 f9 10 00       	mov    %eax,0x10f908
    	if (ticks == TICK_NUM)
  101ce5:	a1 08 f9 10 00       	mov    0x10f908,%eax
  101cea:	83 f8 64             	cmp    $0x64,%eax
  101ced:	75 14                	jne    101d03 <trap_dispatch+0x67>
    	{
    		print_ticks();
  101cef:	e8 2d fb ff ff       	call   101821 <print_ticks>
    		ticks= 0;
  101cf4:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  101cfb:	00 00 00 
    	}
        break;
  101cfe:	e9 a6 00 00 00       	jmp    101da9 <trap_dispatch+0x10d>
  101d03:	e9 a1 00 00 00       	jmp    101da9 <trap_dispatch+0x10d>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101d08:	e8 eb f8 ff ff       	call   1015f8 <cons_getc>
  101d0d:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101d10:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101d14:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101d18:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d1c:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d20:	c7 04 24 29 3a 10 00 	movl   $0x103a29,(%esp)
  101d27:	e8 e6 e5 ff ff       	call   100312 <cprintf>
        break;
  101d2c:	eb 7b                	jmp    101da9 <trap_dispatch+0x10d>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101d2e:	e8 c5 f8 ff ff       	call   1015f8 <cons_getc>
  101d33:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101d36:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101d3a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101d3e:	89 54 24 08          	mov    %edx,0x8(%esp)
  101d42:	89 44 24 04          	mov    %eax,0x4(%esp)
  101d46:	c7 04 24 3b 3a 10 00 	movl   $0x103a3b,(%esp)
  101d4d:	e8 c0 e5 ff ff       	call   100312 <cprintf>
        break;
  101d52:	eb 55                	jmp    101da9 <trap_dispatch+0x10d>
    //LAB1 CHALLENGE 1 : YOUR CODE you should modify below codes.
    case T_SWITCH_TOU:
    case T_SWITCH_TOK:
        panic("T_SWITCH_** ??\n");
  101d54:	c7 44 24 08 4a 3a 10 	movl   $0x103a4a,0x8(%esp)
  101d5b:	00 
  101d5c:	c7 44 24 04 b1 00 00 	movl   $0xb1,0x4(%esp)
  101d63:	00 
  101d64:	c7 04 24 6e 38 10 00 	movl   $0x10386e,(%esp)
  101d6b:	e8 6a ef ff ff       	call   100cda <__panic>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101d70:	8b 45 08             	mov    0x8(%ebp),%eax
  101d73:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101d77:	0f b7 c0             	movzwl %ax,%eax
  101d7a:	83 e0 03             	and    $0x3,%eax
  101d7d:	85 c0                	test   %eax,%eax
  101d7f:	75 28                	jne    101da9 <trap_dispatch+0x10d>
            print_trapframe(tf);
  101d81:	8b 45 08             	mov    0x8(%ebp),%eax
  101d84:	89 04 24             	mov    %eax,(%esp)
  101d87:	e8 94 fc ff ff       	call   101a20 <print_trapframe>
            panic("unexpected trap in kernel.\n");
  101d8c:	c7 44 24 08 5a 3a 10 	movl   $0x103a5a,0x8(%esp)
  101d93:	00 
  101d94:	c7 44 24 04 bb 00 00 	movl   $0xbb,0x4(%esp)
  101d9b:	00 
  101d9c:	c7 04 24 6e 38 10 00 	movl   $0x10386e,(%esp)
  101da3:	e8 32 ef ff ff       	call   100cda <__panic>
        panic("T_SWITCH_** ??\n");
        break;
    case IRQ_OFFSET + IRQ_IDE1:
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
  101da8:	90                   	nop
        if ((tf->tf_cs & 3) == 0) {
            print_trapframe(tf);
            panic("unexpected trap in kernel.\n");
        }
    }
}
  101da9:	c9                   	leave  
  101daa:	c3                   	ret    

00101dab <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101dab:	55                   	push   %ebp
  101dac:	89 e5                	mov    %esp,%ebp
  101dae:	83 ec 18             	sub    $0x18,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101db1:	8b 45 08             	mov    0x8(%ebp),%eax
  101db4:	89 04 24             	mov    %eax,(%esp)
  101db7:	e8 e0 fe ff ff       	call   101c9c <trap_dispatch>
}
  101dbc:	c9                   	leave  
  101dbd:	c3                   	ret    

00101dbe <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  101dbe:	1e                   	push   %ds
    pushl %es
  101dbf:	06                   	push   %es
    pushl %fs
  101dc0:	0f a0                	push   %fs
    pushl %gs
  101dc2:	0f a8                	push   %gs
    pushal
  101dc4:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  101dc5:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  101dca:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  101dcc:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  101dce:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  101dcf:	e8 d7 ff ff ff       	call   101dab <trap>

    # pop the pushed stack pointer
    popl %esp
  101dd4:	5c                   	pop    %esp

00101dd5 <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  101dd5:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  101dd6:	0f a9                	pop    %gs
    popl %fs
  101dd8:	0f a1                	pop    %fs
    popl %es
  101dda:	07                   	pop    %es
    popl %ds
  101ddb:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  101ddc:	83 c4 08             	add    $0x8,%esp
    iret
  101ddf:	cf                   	iret   

00101de0 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101de0:	6a 00                	push   $0x0
  pushl $0
  101de2:	6a 00                	push   $0x0
  jmp __alltraps
  101de4:	e9 d5 ff ff ff       	jmp    101dbe <__alltraps>

00101de9 <vector1>:
.globl vector1
vector1:
  pushl $0
  101de9:	6a 00                	push   $0x0
  pushl $1
  101deb:	6a 01                	push   $0x1
  jmp __alltraps
  101ded:	e9 cc ff ff ff       	jmp    101dbe <__alltraps>

00101df2 <vector2>:
.globl vector2
vector2:
  pushl $0
  101df2:	6a 00                	push   $0x0
  pushl $2
  101df4:	6a 02                	push   $0x2
  jmp __alltraps
  101df6:	e9 c3 ff ff ff       	jmp    101dbe <__alltraps>

00101dfb <vector3>:
.globl vector3
vector3:
  pushl $0
  101dfb:	6a 00                	push   $0x0
  pushl $3
  101dfd:	6a 03                	push   $0x3
  jmp __alltraps
  101dff:	e9 ba ff ff ff       	jmp    101dbe <__alltraps>

00101e04 <vector4>:
.globl vector4
vector4:
  pushl $0
  101e04:	6a 00                	push   $0x0
  pushl $4
  101e06:	6a 04                	push   $0x4
  jmp __alltraps
  101e08:	e9 b1 ff ff ff       	jmp    101dbe <__alltraps>

00101e0d <vector5>:
.globl vector5
vector5:
  pushl $0
  101e0d:	6a 00                	push   $0x0
  pushl $5
  101e0f:	6a 05                	push   $0x5
  jmp __alltraps
  101e11:	e9 a8 ff ff ff       	jmp    101dbe <__alltraps>

00101e16 <vector6>:
.globl vector6
vector6:
  pushl $0
  101e16:	6a 00                	push   $0x0
  pushl $6
  101e18:	6a 06                	push   $0x6
  jmp __alltraps
  101e1a:	e9 9f ff ff ff       	jmp    101dbe <__alltraps>

00101e1f <vector7>:
.globl vector7
vector7:
  pushl $0
  101e1f:	6a 00                	push   $0x0
  pushl $7
  101e21:	6a 07                	push   $0x7
  jmp __alltraps
  101e23:	e9 96 ff ff ff       	jmp    101dbe <__alltraps>

00101e28 <vector8>:
.globl vector8
vector8:
  pushl $8
  101e28:	6a 08                	push   $0x8
  jmp __alltraps
  101e2a:	e9 8f ff ff ff       	jmp    101dbe <__alltraps>

00101e2f <vector9>:
.globl vector9
vector9:
  pushl $9
  101e2f:	6a 09                	push   $0x9
  jmp __alltraps
  101e31:	e9 88 ff ff ff       	jmp    101dbe <__alltraps>

00101e36 <vector10>:
.globl vector10
vector10:
  pushl $10
  101e36:	6a 0a                	push   $0xa
  jmp __alltraps
  101e38:	e9 81 ff ff ff       	jmp    101dbe <__alltraps>

00101e3d <vector11>:
.globl vector11
vector11:
  pushl $11
  101e3d:	6a 0b                	push   $0xb
  jmp __alltraps
  101e3f:	e9 7a ff ff ff       	jmp    101dbe <__alltraps>

00101e44 <vector12>:
.globl vector12
vector12:
  pushl $12
  101e44:	6a 0c                	push   $0xc
  jmp __alltraps
  101e46:	e9 73 ff ff ff       	jmp    101dbe <__alltraps>

00101e4b <vector13>:
.globl vector13
vector13:
  pushl $13
  101e4b:	6a 0d                	push   $0xd
  jmp __alltraps
  101e4d:	e9 6c ff ff ff       	jmp    101dbe <__alltraps>

00101e52 <vector14>:
.globl vector14
vector14:
  pushl $14
  101e52:	6a 0e                	push   $0xe
  jmp __alltraps
  101e54:	e9 65 ff ff ff       	jmp    101dbe <__alltraps>

00101e59 <vector15>:
.globl vector15
vector15:
  pushl $0
  101e59:	6a 00                	push   $0x0
  pushl $15
  101e5b:	6a 0f                	push   $0xf
  jmp __alltraps
  101e5d:	e9 5c ff ff ff       	jmp    101dbe <__alltraps>

00101e62 <vector16>:
.globl vector16
vector16:
  pushl $0
  101e62:	6a 00                	push   $0x0
  pushl $16
  101e64:	6a 10                	push   $0x10
  jmp __alltraps
  101e66:	e9 53 ff ff ff       	jmp    101dbe <__alltraps>

00101e6b <vector17>:
.globl vector17
vector17:
  pushl $17
  101e6b:	6a 11                	push   $0x11
  jmp __alltraps
  101e6d:	e9 4c ff ff ff       	jmp    101dbe <__alltraps>

00101e72 <vector18>:
.globl vector18
vector18:
  pushl $0
  101e72:	6a 00                	push   $0x0
  pushl $18
  101e74:	6a 12                	push   $0x12
  jmp __alltraps
  101e76:	e9 43 ff ff ff       	jmp    101dbe <__alltraps>

00101e7b <vector19>:
.globl vector19
vector19:
  pushl $0
  101e7b:	6a 00                	push   $0x0
  pushl $19
  101e7d:	6a 13                	push   $0x13
  jmp __alltraps
  101e7f:	e9 3a ff ff ff       	jmp    101dbe <__alltraps>

00101e84 <vector20>:
.globl vector20
vector20:
  pushl $0
  101e84:	6a 00                	push   $0x0
  pushl $20
  101e86:	6a 14                	push   $0x14
  jmp __alltraps
  101e88:	e9 31 ff ff ff       	jmp    101dbe <__alltraps>

00101e8d <vector21>:
.globl vector21
vector21:
  pushl $0
  101e8d:	6a 00                	push   $0x0
  pushl $21
  101e8f:	6a 15                	push   $0x15
  jmp __alltraps
  101e91:	e9 28 ff ff ff       	jmp    101dbe <__alltraps>

00101e96 <vector22>:
.globl vector22
vector22:
  pushl $0
  101e96:	6a 00                	push   $0x0
  pushl $22
  101e98:	6a 16                	push   $0x16
  jmp __alltraps
  101e9a:	e9 1f ff ff ff       	jmp    101dbe <__alltraps>

00101e9f <vector23>:
.globl vector23
vector23:
  pushl $0
  101e9f:	6a 00                	push   $0x0
  pushl $23
  101ea1:	6a 17                	push   $0x17
  jmp __alltraps
  101ea3:	e9 16 ff ff ff       	jmp    101dbe <__alltraps>

00101ea8 <vector24>:
.globl vector24
vector24:
  pushl $0
  101ea8:	6a 00                	push   $0x0
  pushl $24
  101eaa:	6a 18                	push   $0x18
  jmp __alltraps
  101eac:	e9 0d ff ff ff       	jmp    101dbe <__alltraps>

00101eb1 <vector25>:
.globl vector25
vector25:
  pushl $0
  101eb1:	6a 00                	push   $0x0
  pushl $25
  101eb3:	6a 19                	push   $0x19
  jmp __alltraps
  101eb5:	e9 04 ff ff ff       	jmp    101dbe <__alltraps>

00101eba <vector26>:
.globl vector26
vector26:
  pushl $0
  101eba:	6a 00                	push   $0x0
  pushl $26
  101ebc:	6a 1a                	push   $0x1a
  jmp __alltraps
  101ebe:	e9 fb fe ff ff       	jmp    101dbe <__alltraps>

00101ec3 <vector27>:
.globl vector27
vector27:
  pushl $0
  101ec3:	6a 00                	push   $0x0
  pushl $27
  101ec5:	6a 1b                	push   $0x1b
  jmp __alltraps
  101ec7:	e9 f2 fe ff ff       	jmp    101dbe <__alltraps>

00101ecc <vector28>:
.globl vector28
vector28:
  pushl $0
  101ecc:	6a 00                	push   $0x0
  pushl $28
  101ece:	6a 1c                	push   $0x1c
  jmp __alltraps
  101ed0:	e9 e9 fe ff ff       	jmp    101dbe <__alltraps>

00101ed5 <vector29>:
.globl vector29
vector29:
  pushl $0
  101ed5:	6a 00                	push   $0x0
  pushl $29
  101ed7:	6a 1d                	push   $0x1d
  jmp __alltraps
  101ed9:	e9 e0 fe ff ff       	jmp    101dbe <__alltraps>

00101ede <vector30>:
.globl vector30
vector30:
  pushl $0
  101ede:	6a 00                	push   $0x0
  pushl $30
  101ee0:	6a 1e                	push   $0x1e
  jmp __alltraps
  101ee2:	e9 d7 fe ff ff       	jmp    101dbe <__alltraps>

00101ee7 <vector31>:
.globl vector31
vector31:
  pushl $0
  101ee7:	6a 00                	push   $0x0
  pushl $31
  101ee9:	6a 1f                	push   $0x1f
  jmp __alltraps
  101eeb:	e9 ce fe ff ff       	jmp    101dbe <__alltraps>

00101ef0 <vector32>:
.globl vector32
vector32:
  pushl $0
  101ef0:	6a 00                	push   $0x0
  pushl $32
  101ef2:	6a 20                	push   $0x20
  jmp __alltraps
  101ef4:	e9 c5 fe ff ff       	jmp    101dbe <__alltraps>

00101ef9 <vector33>:
.globl vector33
vector33:
  pushl $0
  101ef9:	6a 00                	push   $0x0
  pushl $33
  101efb:	6a 21                	push   $0x21
  jmp __alltraps
  101efd:	e9 bc fe ff ff       	jmp    101dbe <__alltraps>

00101f02 <vector34>:
.globl vector34
vector34:
  pushl $0
  101f02:	6a 00                	push   $0x0
  pushl $34
  101f04:	6a 22                	push   $0x22
  jmp __alltraps
  101f06:	e9 b3 fe ff ff       	jmp    101dbe <__alltraps>

00101f0b <vector35>:
.globl vector35
vector35:
  pushl $0
  101f0b:	6a 00                	push   $0x0
  pushl $35
  101f0d:	6a 23                	push   $0x23
  jmp __alltraps
  101f0f:	e9 aa fe ff ff       	jmp    101dbe <__alltraps>

00101f14 <vector36>:
.globl vector36
vector36:
  pushl $0
  101f14:	6a 00                	push   $0x0
  pushl $36
  101f16:	6a 24                	push   $0x24
  jmp __alltraps
  101f18:	e9 a1 fe ff ff       	jmp    101dbe <__alltraps>

00101f1d <vector37>:
.globl vector37
vector37:
  pushl $0
  101f1d:	6a 00                	push   $0x0
  pushl $37
  101f1f:	6a 25                	push   $0x25
  jmp __alltraps
  101f21:	e9 98 fe ff ff       	jmp    101dbe <__alltraps>

00101f26 <vector38>:
.globl vector38
vector38:
  pushl $0
  101f26:	6a 00                	push   $0x0
  pushl $38
  101f28:	6a 26                	push   $0x26
  jmp __alltraps
  101f2a:	e9 8f fe ff ff       	jmp    101dbe <__alltraps>

00101f2f <vector39>:
.globl vector39
vector39:
  pushl $0
  101f2f:	6a 00                	push   $0x0
  pushl $39
  101f31:	6a 27                	push   $0x27
  jmp __alltraps
  101f33:	e9 86 fe ff ff       	jmp    101dbe <__alltraps>

00101f38 <vector40>:
.globl vector40
vector40:
  pushl $0
  101f38:	6a 00                	push   $0x0
  pushl $40
  101f3a:	6a 28                	push   $0x28
  jmp __alltraps
  101f3c:	e9 7d fe ff ff       	jmp    101dbe <__alltraps>

00101f41 <vector41>:
.globl vector41
vector41:
  pushl $0
  101f41:	6a 00                	push   $0x0
  pushl $41
  101f43:	6a 29                	push   $0x29
  jmp __alltraps
  101f45:	e9 74 fe ff ff       	jmp    101dbe <__alltraps>

00101f4a <vector42>:
.globl vector42
vector42:
  pushl $0
  101f4a:	6a 00                	push   $0x0
  pushl $42
  101f4c:	6a 2a                	push   $0x2a
  jmp __alltraps
  101f4e:	e9 6b fe ff ff       	jmp    101dbe <__alltraps>

00101f53 <vector43>:
.globl vector43
vector43:
  pushl $0
  101f53:	6a 00                	push   $0x0
  pushl $43
  101f55:	6a 2b                	push   $0x2b
  jmp __alltraps
  101f57:	e9 62 fe ff ff       	jmp    101dbe <__alltraps>

00101f5c <vector44>:
.globl vector44
vector44:
  pushl $0
  101f5c:	6a 00                	push   $0x0
  pushl $44
  101f5e:	6a 2c                	push   $0x2c
  jmp __alltraps
  101f60:	e9 59 fe ff ff       	jmp    101dbe <__alltraps>

00101f65 <vector45>:
.globl vector45
vector45:
  pushl $0
  101f65:	6a 00                	push   $0x0
  pushl $45
  101f67:	6a 2d                	push   $0x2d
  jmp __alltraps
  101f69:	e9 50 fe ff ff       	jmp    101dbe <__alltraps>

00101f6e <vector46>:
.globl vector46
vector46:
  pushl $0
  101f6e:	6a 00                	push   $0x0
  pushl $46
  101f70:	6a 2e                	push   $0x2e
  jmp __alltraps
  101f72:	e9 47 fe ff ff       	jmp    101dbe <__alltraps>

00101f77 <vector47>:
.globl vector47
vector47:
  pushl $0
  101f77:	6a 00                	push   $0x0
  pushl $47
  101f79:	6a 2f                	push   $0x2f
  jmp __alltraps
  101f7b:	e9 3e fe ff ff       	jmp    101dbe <__alltraps>

00101f80 <vector48>:
.globl vector48
vector48:
  pushl $0
  101f80:	6a 00                	push   $0x0
  pushl $48
  101f82:	6a 30                	push   $0x30
  jmp __alltraps
  101f84:	e9 35 fe ff ff       	jmp    101dbe <__alltraps>

00101f89 <vector49>:
.globl vector49
vector49:
  pushl $0
  101f89:	6a 00                	push   $0x0
  pushl $49
  101f8b:	6a 31                	push   $0x31
  jmp __alltraps
  101f8d:	e9 2c fe ff ff       	jmp    101dbe <__alltraps>

00101f92 <vector50>:
.globl vector50
vector50:
  pushl $0
  101f92:	6a 00                	push   $0x0
  pushl $50
  101f94:	6a 32                	push   $0x32
  jmp __alltraps
  101f96:	e9 23 fe ff ff       	jmp    101dbe <__alltraps>

00101f9b <vector51>:
.globl vector51
vector51:
  pushl $0
  101f9b:	6a 00                	push   $0x0
  pushl $51
  101f9d:	6a 33                	push   $0x33
  jmp __alltraps
  101f9f:	e9 1a fe ff ff       	jmp    101dbe <__alltraps>

00101fa4 <vector52>:
.globl vector52
vector52:
  pushl $0
  101fa4:	6a 00                	push   $0x0
  pushl $52
  101fa6:	6a 34                	push   $0x34
  jmp __alltraps
  101fa8:	e9 11 fe ff ff       	jmp    101dbe <__alltraps>

00101fad <vector53>:
.globl vector53
vector53:
  pushl $0
  101fad:	6a 00                	push   $0x0
  pushl $53
  101faf:	6a 35                	push   $0x35
  jmp __alltraps
  101fb1:	e9 08 fe ff ff       	jmp    101dbe <__alltraps>

00101fb6 <vector54>:
.globl vector54
vector54:
  pushl $0
  101fb6:	6a 00                	push   $0x0
  pushl $54
  101fb8:	6a 36                	push   $0x36
  jmp __alltraps
  101fba:	e9 ff fd ff ff       	jmp    101dbe <__alltraps>

00101fbf <vector55>:
.globl vector55
vector55:
  pushl $0
  101fbf:	6a 00                	push   $0x0
  pushl $55
  101fc1:	6a 37                	push   $0x37
  jmp __alltraps
  101fc3:	e9 f6 fd ff ff       	jmp    101dbe <__alltraps>

00101fc8 <vector56>:
.globl vector56
vector56:
  pushl $0
  101fc8:	6a 00                	push   $0x0
  pushl $56
  101fca:	6a 38                	push   $0x38
  jmp __alltraps
  101fcc:	e9 ed fd ff ff       	jmp    101dbe <__alltraps>

00101fd1 <vector57>:
.globl vector57
vector57:
  pushl $0
  101fd1:	6a 00                	push   $0x0
  pushl $57
  101fd3:	6a 39                	push   $0x39
  jmp __alltraps
  101fd5:	e9 e4 fd ff ff       	jmp    101dbe <__alltraps>

00101fda <vector58>:
.globl vector58
vector58:
  pushl $0
  101fda:	6a 00                	push   $0x0
  pushl $58
  101fdc:	6a 3a                	push   $0x3a
  jmp __alltraps
  101fde:	e9 db fd ff ff       	jmp    101dbe <__alltraps>

00101fe3 <vector59>:
.globl vector59
vector59:
  pushl $0
  101fe3:	6a 00                	push   $0x0
  pushl $59
  101fe5:	6a 3b                	push   $0x3b
  jmp __alltraps
  101fe7:	e9 d2 fd ff ff       	jmp    101dbe <__alltraps>

00101fec <vector60>:
.globl vector60
vector60:
  pushl $0
  101fec:	6a 00                	push   $0x0
  pushl $60
  101fee:	6a 3c                	push   $0x3c
  jmp __alltraps
  101ff0:	e9 c9 fd ff ff       	jmp    101dbe <__alltraps>

00101ff5 <vector61>:
.globl vector61
vector61:
  pushl $0
  101ff5:	6a 00                	push   $0x0
  pushl $61
  101ff7:	6a 3d                	push   $0x3d
  jmp __alltraps
  101ff9:	e9 c0 fd ff ff       	jmp    101dbe <__alltraps>

00101ffe <vector62>:
.globl vector62
vector62:
  pushl $0
  101ffe:	6a 00                	push   $0x0
  pushl $62
  102000:	6a 3e                	push   $0x3e
  jmp __alltraps
  102002:	e9 b7 fd ff ff       	jmp    101dbe <__alltraps>

00102007 <vector63>:
.globl vector63
vector63:
  pushl $0
  102007:	6a 00                	push   $0x0
  pushl $63
  102009:	6a 3f                	push   $0x3f
  jmp __alltraps
  10200b:	e9 ae fd ff ff       	jmp    101dbe <__alltraps>

00102010 <vector64>:
.globl vector64
vector64:
  pushl $0
  102010:	6a 00                	push   $0x0
  pushl $64
  102012:	6a 40                	push   $0x40
  jmp __alltraps
  102014:	e9 a5 fd ff ff       	jmp    101dbe <__alltraps>

00102019 <vector65>:
.globl vector65
vector65:
  pushl $0
  102019:	6a 00                	push   $0x0
  pushl $65
  10201b:	6a 41                	push   $0x41
  jmp __alltraps
  10201d:	e9 9c fd ff ff       	jmp    101dbe <__alltraps>

00102022 <vector66>:
.globl vector66
vector66:
  pushl $0
  102022:	6a 00                	push   $0x0
  pushl $66
  102024:	6a 42                	push   $0x42
  jmp __alltraps
  102026:	e9 93 fd ff ff       	jmp    101dbe <__alltraps>

0010202b <vector67>:
.globl vector67
vector67:
  pushl $0
  10202b:	6a 00                	push   $0x0
  pushl $67
  10202d:	6a 43                	push   $0x43
  jmp __alltraps
  10202f:	e9 8a fd ff ff       	jmp    101dbe <__alltraps>

00102034 <vector68>:
.globl vector68
vector68:
  pushl $0
  102034:	6a 00                	push   $0x0
  pushl $68
  102036:	6a 44                	push   $0x44
  jmp __alltraps
  102038:	e9 81 fd ff ff       	jmp    101dbe <__alltraps>

0010203d <vector69>:
.globl vector69
vector69:
  pushl $0
  10203d:	6a 00                	push   $0x0
  pushl $69
  10203f:	6a 45                	push   $0x45
  jmp __alltraps
  102041:	e9 78 fd ff ff       	jmp    101dbe <__alltraps>

00102046 <vector70>:
.globl vector70
vector70:
  pushl $0
  102046:	6a 00                	push   $0x0
  pushl $70
  102048:	6a 46                	push   $0x46
  jmp __alltraps
  10204a:	e9 6f fd ff ff       	jmp    101dbe <__alltraps>

0010204f <vector71>:
.globl vector71
vector71:
  pushl $0
  10204f:	6a 00                	push   $0x0
  pushl $71
  102051:	6a 47                	push   $0x47
  jmp __alltraps
  102053:	e9 66 fd ff ff       	jmp    101dbe <__alltraps>

00102058 <vector72>:
.globl vector72
vector72:
  pushl $0
  102058:	6a 00                	push   $0x0
  pushl $72
  10205a:	6a 48                	push   $0x48
  jmp __alltraps
  10205c:	e9 5d fd ff ff       	jmp    101dbe <__alltraps>

00102061 <vector73>:
.globl vector73
vector73:
  pushl $0
  102061:	6a 00                	push   $0x0
  pushl $73
  102063:	6a 49                	push   $0x49
  jmp __alltraps
  102065:	e9 54 fd ff ff       	jmp    101dbe <__alltraps>

0010206a <vector74>:
.globl vector74
vector74:
  pushl $0
  10206a:	6a 00                	push   $0x0
  pushl $74
  10206c:	6a 4a                	push   $0x4a
  jmp __alltraps
  10206e:	e9 4b fd ff ff       	jmp    101dbe <__alltraps>

00102073 <vector75>:
.globl vector75
vector75:
  pushl $0
  102073:	6a 00                	push   $0x0
  pushl $75
  102075:	6a 4b                	push   $0x4b
  jmp __alltraps
  102077:	e9 42 fd ff ff       	jmp    101dbe <__alltraps>

0010207c <vector76>:
.globl vector76
vector76:
  pushl $0
  10207c:	6a 00                	push   $0x0
  pushl $76
  10207e:	6a 4c                	push   $0x4c
  jmp __alltraps
  102080:	e9 39 fd ff ff       	jmp    101dbe <__alltraps>

00102085 <vector77>:
.globl vector77
vector77:
  pushl $0
  102085:	6a 00                	push   $0x0
  pushl $77
  102087:	6a 4d                	push   $0x4d
  jmp __alltraps
  102089:	e9 30 fd ff ff       	jmp    101dbe <__alltraps>

0010208e <vector78>:
.globl vector78
vector78:
  pushl $0
  10208e:	6a 00                	push   $0x0
  pushl $78
  102090:	6a 4e                	push   $0x4e
  jmp __alltraps
  102092:	e9 27 fd ff ff       	jmp    101dbe <__alltraps>

00102097 <vector79>:
.globl vector79
vector79:
  pushl $0
  102097:	6a 00                	push   $0x0
  pushl $79
  102099:	6a 4f                	push   $0x4f
  jmp __alltraps
  10209b:	e9 1e fd ff ff       	jmp    101dbe <__alltraps>

001020a0 <vector80>:
.globl vector80
vector80:
  pushl $0
  1020a0:	6a 00                	push   $0x0
  pushl $80
  1020a2:	6a 50                	push   $0x50
  jmp __alltraps
  1020a4:	e9 15 fd ff ff       	jmp    101dbe <__alltraps>

001020a9 <vector81>:
.globl vector81
vector81:
  pushl $0
  1020a9:	6a 00                	push   $0x0
  pushl $81
  1020ab:	6a 51                	push   $0x51
  jmp __alltraps
  1020ad:	e9 0c fd ff ff       	jmp    101dbe <__alltraps>

001020b2 <vector82>:
.globl vector82
vector82:
  pushl $0
  1020b2:	6a 00                	push   $0x0
  pushl $82
  1020b4:	6a 52                	push   $0x52
  jmp __alltraps
  1020b6:	e9 03 fd ff ff       	jmp    101dbe <__alltraps>

001020bb <vector83>:
.globl vector83
vector83:
  pushl $0
  1020bb:	6a 00                	push   $0x0
  pushl $83
  1020bd:	6a 53                	push   $0x53
  jmp __alltraps
  1020bf:	e9 fa fc ff ff       	jmp    101dbe <__alltraps>

001020c4 <vector84>:
.globl vector84
vector84:
  pushl $0
  1020c4:	6a 00                	push   $0x0
  pushl $84
  1020c6:	6a 54                	push   $0x54
  jmp __alltraps
  1020c8:	e9 f1 fc ff ff       	jmp    101dbe <__alltraps>

001020cd <vector85>:
.globl vector85
vector85:
  pushl $0
  1020cd:	6a 00                	push   $0x0
  pushl $85
  1020cf:	6a 55                	push   $0x55
  jmp __alltraps
  1020d1:	e9 e8 fc ff ff       	jmp    101dbe <__alltraps>

001020d6 <vector86>:
.globl vector86
vector86:
  pushl $0
  1020d6:	6a 00                	push   $0x0
  pushl $86
  1020d8:	6a 56                	push   $0x56
  jmp __alltraps
  1020da:	e9 df fc ff ff       	jmp    101dbe <__alltraps>

001020df <vector87>:
.globl vector87
vector87:
  pushl $0
  1020df:	6a 00                	push   $0x0
  pushl $87
  1020e1:	6a 57                	push   $0x57
  jmp __alltraps
  1020e3:	e9 d6 fc ff ff       	jmp    101dbe <__alltraps>

001020e8 <vector88>:
.globl vector88
vector88:
  pushl $0
  1020e8:	6a 00                	push   $0x0
  pushl $88
  1020ea:	6a 58                	push   $0x58
  jmp __alltraps
  1020ec:	e9 cd fc ff ff       	jmp    101dbe <__alltraps>

001020f1 <vector89>:
.globl vector89
vector89:
  pushl $0
  1020f1:	6a 00                	push   $0x0
  pushl $89
  1020f3:	6a 59                	push   $0x59
  jmp __alltraps
  1020f5:	e9 c4 fc ff ff       	jmp    101dbe <__alltraps>

001020fa <vector90>:
.globl vector90
vector90:
  pushl $0
  1020fa:	6a 00                	push   $0x0
  pushl $90
  1020fc:	6a 5a                	push   $0x5a
  jmp __alltraps
  1020fe:	e9 bb fc ff ff       	jmp    101dbe <__alltraps>

00102103 <vector91>:
.globl vector91
vector91:
  pushl $0
  102103:	6a 00                	push   $0x0
  pushl $91
  102105:	6a 5b                	push   $0x5b
  jmp __alltraps
  102107:	e9 b2 fc ff ff       	jmp    101dbe <__alltraps>

0010210c <vector92>:
.globl vector92
vector92:
  pushl $0
  10210c:	6a 00                	push   $0x0
  pushl $92
  10210e:	6a 5c                	push   $0x5c
  jmp __alltraps
  102110:	e9 a9 fc ff ff       	jmp    101dbe <__alltraps>

00102115 <vector93>:
.globl vector93
vector93:
  pushl $0
  102115:	6a 00                	push   $0x0
  pushl $93
  102117:	6a 5d                	push   $0x5d
  jmp __alltraps
  102119:	e9 a0 fc ff ff       	jmp    101dbe <__alltraps>

0010211e <vector94>:
.globl vector94
vector94:
  pushl $0
  10211e:	6a 00                	push   $0x0
  pushl $94
  102120:	6a 5e                	push   $0x5e
  jmp __alltraps
  102122:	e9 97 fc ff ff       	jmp    101dbe <__alltraps>

00102127 <vector95>:
.globl vector95
vector95:
  pushl $0
  102127:	6a 00                	push   $0x0
  pushl $95
  102129:	6a 5f                	push   $0x5f
  jmp __alltraps
  10212b:	e9 8e fc ff ff       	jmp    101dbe <__alltraps>

00102130 <vector96>:
.globl vector96
vector96:
  pushl $0
  102130:	6a 00                	push   $0x0
  pushl $96
  102132:	6a 60                	push   $0x60
  jmp __alltraps
  102134:	e9 85 fc ff ff       	jmp    101dbe <__alltraps>

00102139 <vector97>:
.globl vector97
vector97:
  pushl $0
  102139:	6a 00                	push   $0x0
  pushl $97
  10213b:	6a 61                	push   $0x61
  jmp __alltraps
  10213d:	e9 7c fc ff ff       	jmp    101dbe <__alltraps>

00102142 <vector98>:
.globl vector98
vector98:
  pushl $0
  102142:	6a 00                	push   $0x0
  pushl $98
  102144:	6a 62                	push   $0x62
  jmp __alltraps
  102146:	e9 73 fc ff ff       	jmp    101dbe <__alltraps>

0010214b <vector99>:
.globl vector99
vector99:
  pushl $0
  10214b:	6a 00                	push   $0x0
  pushl $99
  10214d:	6a 63                	push   $0x63
  jmp __alltraps
  10214f:	e9 6a fc ff ff       	jmp    101dbe <__alltraps>

00102154 <vector100>:
.globl vector100
vector100:
  pushl $0
  102154:	6a 00                	push   $0x0
  pushl $100
  102156:	6a 64                	push   $0x64
  jmp __alltraps
  102158:	e9 61 fc ff ff       	jmp    101dbe <__alltraps>

0010215d <vector101>:
.globl vector101
vector101:
  pushl $0
  10215d:	6a 00                	push   $0x0
  pushl $101
  10215f:	6a 65                	push   $0x65
  jmp __alltraps
  102161:	e9 58 fc ff ff       	jmp    101dbe <__alltraps>

00102166 <vector102>:
.globl vector102
vector102:
  pushl $0
  102166:	6a 00                	push   $0x0
  pushl $102
  102168:	6a 66                	push   $0x66
  jmp __alltraps
  10216a:	e9 4f fc ff ff       	jmp    101dbe <__alltraps>

0010216f <vector103>:
.globl vector103
vector103:
  pushl $0
  10216f:	6a 00                	push   $0x0
  pushl $103
  102171:	6a 67                	push   $0x67
  jmp __alltraps
  102173:	e9 46 fc ff ff       	jmp    101dbe <__alltraps>

00102178 <vector104>:
.globl vector104
vector104:
  pushl $0
  102178:	6a 00                	push   $0x0
  pushl $104
  10217a:	6a 68                	push   $0x68
  jmp __alltraps
  10217c:	e9 3d fc ff ff       	jmp    101dbe <__alltraps>

00102181 <vector105>:
.globl vector105
vector105:
  pushl $0
  102181:	6a 00                	push   $0x0
  pushl $105
  102183:	6a 69                	push   $0x69
  jmp __alltraps
  102185:	e9 34 fc ff ff       	jmp    101dbe <__alltraps>

0010218a <vector106>:
.globl vector106
vector106:
  pushl $0
  10218a:	6a 00                	push   $0x0
  pushl $106
  10218c:	6a 6a                	push   $0x6a
  jmp __alltraps
  10218e:	e9 2b fc ff ff       	jmp    101dbe <__alltraps>

00102193 <vector107>:
.globl vector107
vector107:
  pushl $0
  102193:	6a 00                	push   $0x0
  pushl $107
  102195:	6a 6b                	push   $0x6b
  jmp __alltraps
  102197:	e9 22 fc ff ff       	jmp    101dbe <__alltraps>

0010219c <vector108>:
.globl vector108
vector108:
  pushl $0
  10219c:	6a 00                	push   $0x0
  pushl $108
  10219e:	6a 6c                	push   $0x6c
  jmp __alltraps
  1021a0:	e9 19 fc ff ff       	jmp    101dbe <__alltraps>

001021a5 <vector109>:
.globl vector109
vector109:
  pushl $0
  1021a5:	6a 00                	push   $0x0
  pushl $109
  1021a7:	6a 6d                	push   $0x6d
  jmp __alltraps
  1021a9:	e9 10 fc ff ff       	jmp    101dbe <__alltraps>

001021ae <vector110>:
.globl vector110
vector110:
  pushl $0
  1021ae:	6a 00                	push   $0x0
  pushl $110
  1021b0:	6a 6e                	push   $0x6e
  jmp __alltraps
  1021b2:	e9 07 fc ff ff       	jmp    101dbe <__alltraps>

001021b7 <vector111>:
.globl vector111
vector111:
  pushl $0
  1021b7:	6a 00                	push   $0x0
  pushl $111
  1021b9:	6a 6f                	push   $0x6f
  jmp __alltraps
  1021bb:	e9 fe fb ff ff       	jmp    101dbe <__alltraps>

001021c0 <vector112>:
.globl vector112
vector112:
  pushl $0
  1021c0:	6a 00                	push   $0x0
  pushl $112
  1021c2:	6a 70                	push   $0x70
  jmp __alltraps
  1021c4:	e9 f5 fb ff ff       	jmp    101dbe <__alltraps>

001021c9 <vector113>:
.globl vector113
vector113:
  pushl $0
  1021c9:	6a 00                	push   $0x0
  pushl $113
  1021cb:	6a 71                	push   $0x71
  jmp __alltraps
  1021cd:	e9 ec fb ff ff       	jmp    101dbe <__alltraps>

001021d2 <vector114>:
.globl vector114
vector114:
  pushl $0
  1021d2:	6a 00                	push   $0x0
  pushl $114
  1021d4:	6a 72                	push   $0x72
  jmp __alltraps
  1021d6:	e9 e3 fb ff ff       	jmp    101dbe <__alltraps>

001021db <vector115>:
.globl vector115
vector115:
  pushl $0
  1021db:	6a 00                	push   $0x0
  pushl $115
  1021dd:	6a 73                	push   $0x73
  jmp __alltraps
  1021df:	e9 da fb ff ff       	jmp    101dbe <__alltraps>

001021e4 <vector116>:
.globl vector116
vector116:
  pushl $0
  1021e4:	6a 00                	push   $0x0
  pushl $116
  1021e6:	6a 74                	push   $0x74
  jmp __alltraps
  1021e8:	e9 d1 fb ff ff       	jmp    101dbe <__alltraps>

001021ed <vector117>:
.globl vector117
vector117:
  pushl $0
  1021ed:	6a 00                	push   $0x0
  pushl $117
  1021ef:	6a 75                	push   $0x75
  jmp __alltraps
  1021f1:	e9 c8 fb ff ff       	jmp    101dbe <__alltraps>

001021f6 <vector118>:
.globl vector118
vector118:
  pushl $0
  1021f6:	6a 00                	push   $0x0
  pushl $118
  1021f8:	6a 76                	push   $0x76
  jmp __alltraps
  1021fa:	e9 bf fb ff ff       	jmp    101dbe <__alltraps>

001021ff <vector119>:
.globl vector119
vector119:
  pushl $0
  1021ff:	6a 00                	push   $0x0
  pushl $119
  102201:	6a 77                	push   $0x77
  jmp __alltraps
  102203:	e9 b6 fb ff ff       	jmp    101dbe <__alltraps>

00102208 <vector120>:
.globl vector120
vector120:
  pushl $0
  102208:	6a 00                	push   $0x0
  pushl $120
  10220a:	6a 78                	push   $0x78
  jmp __alltraps
  10220c:	e9 ad fb ff ff       	jmp    101dbe <__alltraps>

00102211 <vector121>:
.globl vector121
vector121:
  pushl $0
  102211:	6a 00                	push   $0x0
  pushl $121
  102213:	6a 79                	push   $0x79
  jmp __alltraps
  102215:	e9 a4 fb ff ff       	jmp    101dbe <__alltraps>

0010221a <vector122>:
.globl vector122
vector122:
  pushl $0
  10221a:	6a 00                	push   $0x0
  pushl $122
  10221c:	6a 7a                	push   $0x7a
  jmp __alltraps
  10221e:	e9 9b fb ff ff       	jmp    101dbe <__alltraps>

00102223 <vector123>:
.globl vector123
vector123:
  pushl $0
  102223:	6a 00                	push   $0x0
  pushl $123
  102225:	6a 7b                	push   $0x7b
  jmp __alltraps
  102227:	e9 92 fb ff ff       	jmp    101dbe <__alltraps>

0010222c <vector124>:
.globl vector124
vector124:
  pushl $0
  10222c:	6a 00                	push   $0x0
  pushl $124
  10222e:	6a 7c                	push   $0x7c
  jmp __alltraps
  102230:	e9 89 fb ff ff       	jmp    101dbe <__alltraps>

00102235 <vector125>:
.globl vector125
vector125:
  pushl $0
  102235:	6a 00                	push   $0x0
  pushl $125
  102237:	6a 7d                	push   $0x7d
  jmp __alltraps
  102239:	e9 80 fb ff ff       	jmp    101dbe <__alltraps>

0010223e <vector126>:
.globl vector126
vector126:
  pushl $0
  10223e:	6a 00                	push   $0x0
  pushl $126
  102240:	6a 7e                	push   $0x7e
  jmp __alltraps
  102242:	e9 77 fb ff ff       	jmp    101dbe <__alltraps>

00102247 <vector127>:
.globl vector127
vector127:
  pushl $0
  102247:	6a 00                	push   $0x0
  pushl $127
  102249:	6a 7f                	push   $0x7f
  jmp __alltraps
  10224b:	e9 6e fb ff ff       	jmp    101dbe <__alltraps>

00102250 <vector128>:
.globl vector128
vector128:
  pushl $0
  102250:	6a 00                	push   $0x0
  pushl $128
  102252:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  102257:	e9 62 fb ff ff       	jmp    101dbe <__alltraps>

0010225c <vector129>:
.globl vector129
vector129:
  pushl $0
  10225c:	6a 00                	push   $0x0
  pushl $129
  10225e:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102263:	e9 56 fb ff ff       	jmp    101dbe <__alltraps>

00102268 <vector130>:
.globl vector130
vector130:
  pushl $0
  102268:	6a 00                	push   $0x0
  pushl $130
  10226a:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  10226f:	e9 4a fb ff ff       	jmp    101dbe <__alltraps>

00102274 <vector131>:
.globl vector131
vector131:
  pushl $0
  102274:	6a 00                	push   $0x0
  pushl $131
  102276:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  10227b:	e9 3e fb ff ff       	jmp    101dbe <__alltraps>

00102280 <vector132>:
.globl vector132
vector132:
  pushl $0
  102280:	6a 00                	push   $0x0
  pushl $132
  102282:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  102287:	e9 32 fb ff ff       	jmp    101dbe <__alltraps>

0010228c <vector133>:
.globl vector133
vector133:
  pushl $0
  10228c:	6a 00                	push   $0x0
  pushl $133
  10228e:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  102293:	e9 26 fb ff ff       	jmp    101dbe <__alltraps>

00102298 <vector134>:
.globl vector134
vector134:
  pushl $0
  102298:	6a 00                	push   $0x0
  pushl $134
  10229a:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  10229f:	e9 1a fb ff ff       	jmp    101dbe <__alltraps>

001022a4 <vector135>:
.globl vector135
vector135:
  pushl $0
  1022a4:	6a 00                	push   $0x0
  pushl $135
  1022a6:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  1022ab:	e9 0e fb ff ff       	jmp    101dbe <__alltraps>

001022b0 <vector136>:
.globl vector136
vector136:
  pushl $0
  1022b0:	6a 00                	push   $0x0
  pushl $136
  1022b2:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1022b7:	e9 02 fb ff ff       	jmp    101dbe <__alltraps>

001022bc <vector137>:
.globl vector137
vector137:
  pushl $0
  1022bc:	6a 00                	push   $0x0
  pushl $137
  1022be:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1022c3:	e9 f6 fa ff ff       	jmp    101dbe <__alltraps>

001022c8 <vector138>:
.globl vector138
vector138:
  pushl $0
  1022c8:	6a 00                	push   $0x0
  pushl $138
  1022ca:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1022cf:	e9 ea fa ff ff       	jmp    101dbe <__alltraps>

001022d4 <vector139>:
.globl vector139
vector139:
  pushl $0
  1022d4:	6a 00                	push   $0x0
  pushl $139
  1022d6:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1022db:	e9 de fa ff ff       	jmp    101dbe <__alltraps>

001022e0 <vector140>:
.globl vector140
vector140:
  pushl $0
  1022e0:	6a 00                	push   $0x0
  pushl $140
  1022e2:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1022e7:	e9 d2 fa ff ff       	jmp    101dbe <__alltraps>

001022ec <vector141>:
.globl vector141
vector141:
  pushl $0
  1022ec:	6a 00                	push   $0x0
  pushl $141
  1022ee:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  1022f3:	e9 c6 fa ff ff       	jmp    101dbe <__alltraps>

001022f8 <vector142>:
.globl vector142
vector142:
  pushl $0
  1022f8:	6a 00                	push   $0x0
  pushl $142
  1022fa:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  1022ff:	e9 ba fa ff ff       	jmp    101dbe <__alltraps>

00102304 <vector143>:
.globl vector143
vector143:
  pushl $0
  102304:	6a 00                	push   $0x0
  pushl $143
  102306:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  10230b:	e9 ae fa ff ff       	jmp    101dbe <__alltraps>

00102310 <vector144>:
.globl vector144
vector144:
  pushl $0
  102310:	6a 00                	push   $0x0
  pushl $144
  102312:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  102317:	e9 a2 fa ff ff       	jmp    101dbe <__alltraps>

0010231c <vector145>:
.globl vector145
vector145:
  pushl $0
  10231c:	6a 00                	push   $0x0
  pushl $145
  10231e:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  102323:	e9 96 fa ff ff       	jmp    101dbe <__alltraps>

00102328 <vector146>:
.globl vector146
vector146:
  pushl $0
  102328:	6a 00                	push   $0x0
  pushl $146
  10232a:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  10232f:	e9 8a fa ff ff       	jmp    101dbe <__alltraps>

00102334 <vector147>:
.globl vector147
vector147:
  pushl $0
  102334:	6a 00                	push   $0x0
  pushl $147
  102336:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  10233b:	e9 7e fa ff ff       	jmp    101dbe <__alltraps>

00102340 <vector148>:
.globl vector148
vector148:
  pushl $0
  102340:	6a 00                	push   $0x0
  pushl $148
  102342:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  102347:	e9 72 fa ff ff       	jmp    101dbe <__alltraps>

0010234c <vector149>:
.globl vector149
vector149:
  pushl $0
  10234c:	6a 00                	push   $0x0
  pushl $149
  10234e:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102353:	e9 66 fa ff ff       	jmp    101dbe <__alltraps>

00102358 <vector150>:
.globl vector150
vector150:
  pushl $0
  102358:	6a 00                	push   $0x0
  pushl $150
  10235a:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  10235f:	e9 5a fa ff ff       	jmp    101dbe <__alltraps>

00102364 <vector151>:
.globl vector151
vector151:
  pushl $0
  102364:	6a 00                	push   $0x0
  pushl $151
  102366:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  10236b:	e9 4e fa ff ff       	jmp    101dbe <__alltraps>

00102370 <vector152>:
.globl vector152
vector152:
  pushl $0
  102370:	6a 00                	push   $0x0
  pushl $152
  102372:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  102377:	e9 42 fa ff ff       	jmp    101dbe <__alltraps>

0010237c <vector153>:
.globl vector153
vector153:
  pushl $0
  10237c:	6a 00                	push   $0x0
  pushl $153
  10237e:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102383:	e9 36 fa ff ff       	jmp    101dbe <__alltraps>

00102388 <vector154>:
.globl vector154
vector154:
  pushl $0
  102388:	6a 00                	push   $0x0
  pushl $154
  10238a:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  10238f:	e9 2a fa ff ff       	jmp    101dbe <__alltraps>

00102394 <vector155>:
.globl vector155
vector155:
  pushl $0
  102394:	6a 00                	push   $0x0
  pushl $155
  102396:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  10239b:	e9 1e fa ff ff       	jmp    101dbe <__alltraps>

001023a0 <vector156>:
.globl vector156
vector156:
  pushl $0
  1023a0:	6a 00                	push   $0x0
  pushl $156
  1023a2:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  1023a7:	e9 12 fa ff ff       	jmp    101dbe <__alltraps>

001023ac <vector157>:
.globl vector157
vector157:
  pushl $0
  1023ac:	6a 00                	push   $0x0
  pushl $157
  1023ae:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1023b3:	e9 06 fa ff ff       	jmp    101dbe <__alltraps>

001023b8 <vector158>:
.globl vector158
vector158:
  pushl $0
  1023b8:	6a 00                	push   $0x0
  pushl $158
  1023ba:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1023bf:	e9 fa f9 ff ff       	jmp    101dbe <__alltraps>

001023c4 <vector159>:
.globl vector159
vector159:
  pushl $0
  1023c4:	6a 00                	push   $0x0
  pushl $159
  1023c6:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1023cb:	e9 ee f9 ff ff       	jmp    101dbe <__alltraps>

001023d0 <vector160>:
.globl vector160
vector160:
  pushl $0
  1023d0:	6a 00                	push   $0x0
  pushl $160
  1023d2:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1023d7:	e9 e2 f9 ff ff       	jmp    101dbe <__alltraps>

001023dc <vector161>:
.globl vector161
vector161:
  pushl $0
  1023dc:	6a 00                	push   $0x0
  pushl $161
  1023de:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1023e3:	e9 d6 f9 ff ff       	jmp    101dbe <__alltraps>

001023e8 <vector162>:
.globl vector162
vector162:
  pushl $0
  1023e8:	6a 00                	push   $0x0
  pushl $162
  1023ea:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  1023ef:	e9 ca f9 ff ff       	jmp    101dbe <__alltraps>

001023f4 <vector163>:
.globl vector163
vector163:
  pushl $0
  1023f4:	6a 00                	push   $0x0
  pushl $163
  1023f6:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  1023fb:	e9 be f9 ff ff       	jmp    101dbe <__alltraps>

00102400 <vector164>:
.globl vector164
vector164:
  pushl $0
  102400:	6a 00                	push   $0x0
  pushl $164
  102402:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  102407:	e9 b2 f9 ff ff       	jmp    101dbe <__alltraps>

0010240c <vector165>:
.globl vector165
vector165:
  pushl $0
  10240c:	6a 00                	push   $0x0
  pushl $165
  10240e:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  102413:	e9 a6 f9 ff ff       	jmp    101dbe <__alltraps>

00102418 <vector166>:
.globl vector166
vector166:
  pushl $0
  102418:	6a 00                	push   $0x0
  pushl $166
  10241a:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  10241f:	e9 9a f9 ff ff       	jmp    101dbe <__alltraps>

00102424 <vector167>:
.globl vector167
vector167:
  pushl $0
  102424:	6a 00                	push   $0x0
  pushl $167
  102426:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  10242b:	e9 8e f9 ff ff       	jmp    101dbe <__alltraps>

00102430 <vector168>:
.globl vector168
vector168:
  pushl $0
  102430:	6a 00                	push   $0x0
  pushl $168
  102432:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  102437:	e9 82 f9 ff ff       	jmp    101dbe <__alltraps>

0010243c <vector169>:
.globl vector169
vector169:
  pushl $0
  10243c:	6a 00                	push   $0x0
  pushl $169
  10243e:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102443:	e9 76 f9 ff ff       	jmp    101dbe <__alltraps>

00102448 <vector170>:
.globl vector170
vector170:
  pushl $0
  102448:	6a 00                	push   $0x0
  pushl $170
  10244a:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  10244f:	e9 6a f9 ff ff       	jmp    101dbe <__alltraps>

00102454 <vector171>:
.globl vector171
vector171:
  pushl $0
  102454:	6a 00                	push   $0x0
  pushl $171
  102456:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  10245b:	e9 5e f9 ff ff       	jmp    101dbe <__alltraps>

00102460 <vector172>:
.globl vector172
vector172:
  pushl $0
  102460:	6a 00                	push   $0x0
  pushl $172
  102462:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  102467:	e9 52 f9 ff ff       	jmp    101dbe <__alltraps>

0010246c <vector173>:
.globl vector173
vector173:
  pushl $0
  10246c:	6a 00                	push   $0x0
  pushl $173
  10246e:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102473:	e9 46 f9 ff ff       	jmp    101dbe <__alltraps>

00102478 <vector174>:
.globl vector174
vector174:
  pushl $0
  102478:	6a 00                	push   $0x0
  pushl $174
  10247a:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  10247f:	e9 3a f9 ff ff       	jmp    101dbe <__alltraps>

00102484 <vector175>:
.globl vector175
vector175:
  pushl $0
  102484:	6a 00                	push   $0x0
  pushl $175
  102486:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  10248b:	e9 2e f9 ff ff       	jmp    101dbe <__alltraps>

00102490 <vector176>:
.globl vector176
vector176:
  pushl $0
  102490:	6a 00                	push   $0x0
  pushl $176
  102492:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  102497:	e9 22 f9 ff ff       	jmp    101dbe <__alltraps>

0010249c <vector177>:
.globl vector177
vector177:
  pushl $0
  10249c:	6a 00                	push   $0x0
  pushl $177
  10249e:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  1024a3:	e9 16 f9 ff ff       	jmp    101dbe <__alltraps>

001024a8 <vector178>:
.globl vector178
vector178:
  pushl $0
  1024a8:	6a 00                	push   $0x0
  pushl $178
  1024aa:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1024af:	e9 0a f9 ff ff       	jmp    101dbe <__alltraps>

001024b4 <vector179>:
.globl vector179
vector179:
  pushl $0
  1024b4:	6a 00                	push   $0x0
  pushl $179
  1024b6:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1024bb:	e9 fe f8 ff ff       	jmp    101dbe <__alltraps>

001024c0 <vector180>:
.globl vector180
vector180:
  pushl $0
  1024c0:	6a 00                	push   $0x0
  pushl $180
  1024c2:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1024c7:	e9 f2 f8 ff ff       	jmp    101dbe <__alltraps>

001024cc <vector181>:
.globl vector181
vector181:
  pushl $0
  1024cc:	6a 00                	push   $0x0
  pushl $181
  1024ce:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1024d3:	e9 e6 f8 ff ff       	jmp    101dbe <__alltraps>

001024d8 <vector182>:
.globl vector182
vector182:
  pushl $0
  1024d8:	6a 00                	push   $0x0
  pushl $182
  1024da:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1024df:	e9 da f8 ff ff       	jmp    101dbe <__alltraps>

001024e4 <vector183>:
.globl vector183
vector183:
  pushl $0
  1024e4:	6a 00                	push   $0x0
  pushl $183
  1024e6:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  1024eb:	e9 ce f8 ff ff       	jmp    101dbe <__alltraps>

001024f0 <vector184>:
.globl vector184
vector184:
  pushl $0
  1024f0:	6a 00                	push   $0x0
  pushl $184
  1024f2:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  1024f7:	e9 c2 f8 ff ff       	jmp    101dbe <__alltraps>

001024fc <vector185>:
.globl vector185
vector185:
  pushl $0
  1024fc:	6a 00                	push   $0x0
  pushl $185
  1024fe:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  102503:	e9 b6 f8 ff ff       	jmp    101dbe <__alltraps>

00102508 <vector186>:
.globl vector186
vector186:
  pushl $0
  102508:	6a 00                	push   $0x0
  pushl $186
  10250a:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  10250f:	e9 aa f8 ff ff       	jmp    101dbe <__alltraps>

00102514 <vector187>:
.globl vector187
vector187:
  pushl $0
  102514:	6a 00                	push   $0x0
  pushl $187
  102516:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  10251b:	e9 9e f8 ff ff       	jmp    101dbe <__alltraps>

00102520 <vector188>:
.globl vector188
vector188:
  pushl $0
  102520:	6a 00                	push   $0x0
  pushl $188
  102522:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  102527:	e9 92 f8 ff ff       	jmp    101dbe <__alltraps>

0010252c <vector189>:
.globl vector189
vector189:
  pushl $0
  10252c:	6a 00                	push   $0x0
  pushl $189
  10252e:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102533:	e9 86 f8 ff ff       	jmp    101dbe <__alltraps>

00102538 <vector190>:
.globl vector190
vector190:
  pushl $0
  102538:	6a 00                	push   $0x0
  pushl $190
  10253a:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  10253f:	e9 7a f8 ff ff       	jmp    101dbe <__alltraps>

00102544 <vector191>:
.globl vector191
vector191:
  pushl $0
  102544:	6a 00                	push   $0x0
  pushl $191
  102546:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  10254b:	e9 6e f8 ff ff       	jmp    101dbe <__alltraps>

00102550 <vector192>:
.globl vector192
vector192:
  pushl $0
  102550:	6a 00                	push   $0x0
  pushl $192
  102552:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  102557:	e9 62 f8 ff ff       	jmp    101dbe <__alltraps>

0010255c <vector193>:
.globl vector193
vector193:
  pushl $0
  10255c:	6a 00                	push   $0x0
  pushl $193
  10255e:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102563:	e9 56 f8 ff ff       	jmp    101dbe <__alltraps>

00102568 <vector194>:
.globl vector194
vector194:
  pushl $0
  102568:	6a 00                	push   $0x0
  pushl $194
  10256a:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  10256f:	e9 4a f8 ff ff       	jmp    101dbe <__alltraps>

00102574 <vector195>:
.globl vector195
vector195:
  pushl $0
  102574:	6a 00                	push   $0x0
  pushl $195
  102576:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  10257b:	e9 3e f8 ff ff       	jmp    101dbe <__alltraps>

00102580 <vector196>:
.globl vector196
vector196:
  pushl $0
  102580:	6a 00                	push   $0x0
  pushl $196
  102582:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  102587:	e9 32 f8 ff ff       	jmp    101dbe <__alltraps>

0010258c <vector197>:
.globl vector197
vector197:
  pushl $0
  10258c:	6a 00                	push   $0x0
  pushl $197
  10258e:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  102593:	e9 26 f8 ff ff       	jmp    101dbe <__alltraps>

00102598 <vector198>:
.globl vector198
vector198:
  pushl $0
  102598:	6a 00                	push   $0x0
  pushl $198
  10259a:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  10259f:	e9 1a f8 ff ff       	jmp    101dbe <__alltraps>

001025a4 <vector199>:
.globl vector199
vector199:
  pushl $0
  1025a4:	6a 00                	push   $0x0
  pushl $199
  1025a6:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  1025ab:	e9 0e f8 ff ff       	jmp    101dbe <__alltraps>

001025b0 <vector200>:
.globl vector200
vector200:
  pushl $0
  1025b0:	6a 00                	push   $0x0
  pushl $200
  1025b2:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1025b7:	e9 02 f8 ff ff       	jmp    101dbe <__alltraps>

001025bc <vector201>:
.globl vector201
vector201:
  pushl $0
  1025bc:	6a 00                	push   $0x0
  pushl $201
  1025be:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1025c3:	e9 f6 f7 ff ff       	jmp    101dbe <__alltraps>

001025c8 <vector202>:
.globl vector202
vector202:
  pushl $0
  1025c8:	6a 00                	push   $0x0
  pushl $202
  1025ca:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1025cf:	e9 ea f7 ff ff       	jmp    101dbe <__alltraps>

001025d4 <vector203>:
.globl vector203
vector203:
  pushl $0
  1025d4:	6a 00                	push   $0x0
  pushl $203
  1025d6:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1025db:	e9 de f7 ff ff       	jmp    101dbe <__alltraps>

001025e0 <vector204>:
.globl vector204
vector204:
  pushl $0
  1025e0:	6a 00                	push   $0x0
  pushl $204
  1025e2:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1025e7:	e9 d2 f7 ff ff       	jmp    101dbe <__alltraps>

001025ec <vector205>:
.globl vector205
vector205:
  pushl $0
  1025ec:	6a 00                	push   $0x0
  pushl $205
  1025ee:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  1025f3:	e9 c6 f7 ff ff       	jmp    101dbe <__alltraps>

001025f8 <vector206>:
.globl vector206
vector206:
  pushl $0
  1025f8:	6a 00                	push   $0x0
  pushl $206
  1025fa:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  1025ff:	e9 ba f7 ff ff       	jmp    101dbe <__alltraps>

00102604 <vector207>:
.globl vector207
vector207:
  pushl $0
  102604:	6a 00                	push   $0x0
  pushl $207
  102606:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  10260b:	e9 ae f7 ff ff       	jmp    101dbe <__alltraps>

00102610 <vector208>:
.globl vector208
vector208:
  pushl $0
  102610:	6a 00                	push   $0x0
  pushl $208
  102612:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  102617:	e9 a2 f7 ff ff       	jmp    101dbe <__alltraps>

0010261c <vector209>:
.globl vector209
vector209:
  pushl $0
  10261c:	6a 00                	push   $0x0
  pushl $209
  10261e:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102623:	e9 96 f7 ff ff       	jmp    101dbe <__alltraps>

00102628 <vector210>:
.globl vector210
vector210:
  pushl $0
  102628:	6a 00                	push   $0x0
  pushl $210
  10262a:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  10262f:	e9 8a f7 ff ff       	jmp    101dbe <__alltraps>

00102634 <vector211>:
.globl vector211
vector211:
  pushl $0
  102634:	6a 00                	push   $0x0
  pushl $211
  102636:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  10263b:	e9 7e f7 ff ff       	jmp    101dbe <__alltraps>

00102640 <vector212>:
.globl vector212
vector212:
  pushl $0
  102640:	6a 00                	push   $0x0
  pushl $212
  102642:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  102647:	e9 72 f7 ff ff       	jmp    101dbe <__alltraps>

0010264c <vector213>:
.globl vector213
vector213:
  pushl $0
  10264c:	6a 00                	push   $0x0
  pushl $213
  10264e:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102653:	e9 66 f7 ff ff       	jmp    101dbe <__alltraps>

00102658 <vector214>:
.globl vector214
vector214:
  pushl $0
  102658:	6a 00                	push   $0x0
  pushl $214
  10265a:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  10265f:	e9 5a f7 ff ff       	jmp    101dbe <__alltraps>

00102664 <vector215>:
.globl vector215
vector215:
  pushl $0
  102664:	6a 00                	push   $0x0
  pushl $215
  102666:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  10266b:	e9 4e f7 ff ff       	jmp    101dbe <__alltraps>

00102670 <vector216>:
.globl vector216
vector216:
  pushl $0
  102670:	6a 00                	push   $0x0
  pushl $216
  102672:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  102677:	e9 42 f7 ff ff       	jmp    101dbe <__alltraps>

0010267c <vector217>:
.globl vector217
vector217:
  pushl $0
  10267c:	6a 00                	push   $0x0
  pushl $217
  10267e:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102683:	e9 36 f7 ff ff       	jmp    101dbe <__alltraps>

00102688 <vector218>:
.globl vector218
vector218:
  pushl $0
  102688:	6a 00                	push   $0x0
  pushl $218
  10268a:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  10268f:	e9 2a f7 ff ff       	jmp    101dbe <__alltraps>

00102694 <vector219>:
.globl vector219
vector219:
  pushl $0
  102694:	6a 00                	push   $0x0
  pushl $219
  102696:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  10269b:	e9 1e f7 ff ff       	jmp    101dbe <__alltraps>

001026a0 <vector220>:
.globl vector220
vector220:
  pushl $0
  1026a0:	6a 00                	push   $0x0
  pushl $220
  1026a2:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  1026a7:	e9 12 f7 ff ff       	jmp    101dbe <__alltraps>

001026ac <vector221>:
.globl vector221
vector221:
  pushl $0
  1026ac:	6a 00                	push   $0x0
  pushl $221
  1026ae:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  1026b3:	e9 06 f7 ff ff       	jmp    101dbe <__alltraps>

001026b8 <vector222>:
.globl vector222
vector222:
  pushl $0
  1026b8:	6a 00                	push   $0x0
  pushl $222
  1026ba:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1026bf:	e9 fa f6 ff ff       	jmp    101dbe <__alltraps>

001026c4 <vector223>:
.globl vector223
vector223:
  pushl $0
  1026c4:	6a 00                	push   $0x0
  pushl $223
  1026c6:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1026cb:	e9 ee f6 ff ff       	jmp    101dbe <__alltraps>

001026d0 <vector224>:
.globl vector224
vector224:
  pushl $0
  1026d0:	6a 00                	push   $0x0
  pushl $224
  1026d2:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1026d7:	e9 e2 f6 ff ff       	jmp    101dbe <__alltraps>

001026dc <vector225>:
.globl vector225
vector225:
  pushl $0
  1026dc:	6a 00                	push   $0x0
  pushl $225
  1026de:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1026e3:	e9 d6 f6 ff ff       	jmp    101dbe <__alltraps>

001026e8 <vector226>:
.globl vector226
vector226:
  pushl $0
  1026e8:	6a 00                	push   $0x0
  pushl $226
  1026ea:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  1026ef:	e9 ca f6 ff ff       	jmp    101dbe <__alltraps>

001026f4 <vector227>:
.globl vector227
vector227:
  pushl $0
  1026f4:	6a 00                	push   $0x0
  pushl $227
  1026f6:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  1026fb:	e9 be f6 ff ff       	jmp    101dbe <__alltraps>

00102700 <vector228>:
.globl vector228
vector228:
  pushl $0
  102700:	6a 00                	push   $0x0
  pushl $228
  102702:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  102707:	e9 b2 f6 ff ff       	jmp    101dbe <__alltraps>

0010270c <vector229>:
.globl vector229
vector229:
  pushl $0
  10270c:	6a 00                	push   $0x0
  pushl $229
  10270e:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102713:	e9 a6 f6 ff ff       	jmp    101dbe <__alltraps>

00102718 <vector230>:
.globl vector230
vector230:
  pushl $0
  102718:	6a 00                	push   $0x0
  pushl $230
  10271a:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  10271f:	e9 9a f6 ff ff       	jmp    101dbe <__alltraps>

00102724 <vector231>:
.globl vector231
vector231:
  pushl $0
  102724:	6a 00                	push   $0x0
  pushl $231
  102726:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  10272b:	e9 8e f6 ff ff       	jmp    101dbe <__alltraps>

00102730 <vector232>:
.globl vector232
vector232:
  pushl $0
  102730:	6a 00                	push   $0x0
  pushl $232
  102732:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  102737:	e9 82 f6 ff ff       	jmp    101dbe <__alltraps>

0010273c <vector233>:
.globl vector233
vector233:
  pushl $0
  10273c:	6a 00                	push   $0x0
  pushl $233
  10273e:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102743:	e9 76 f6 ff ff       	jmp    101dbe <__alltraps>

00102748 <vector234>:
.globl vector234
vector234:
  pushl $0
  102748:	6a 00                	push   $0x0
  pushl $234
  10274a:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  10274f:	e9 6a f6 ff ff       	jmp    101dbe <__alltraps>

00102754 <vector235>:
.globl vector235
vector235:
  pushl $0
  102754:	6a 00                	push   $0x0
  pushl $235
  102756:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  10275b:	e9 5e f6 ff ff       	jmp    101dbe <__alltraps>

00102760 <vector236>:
.globl vector236
vector236:
  pushl $0
  102760:	6a 00                	push   $0x0
  pushl $236
  102762:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  102767:	e9 52 f6 ff ff       	jmp    101dbe <__alltraps>

0010276c <vector237>:
.globl vector237
vector237:
  pushl $0
  10276c:	6a 00                	push   $0x0
  pushl $237
  10276e:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102773:	e9 46 f6 ff ff       	jmp    101dbe <__alltraps>

00102778 <vector238>:
.globl vector238
vector238:
  pushl $0
  102778:	6a 00                	push   $0x0
  pushl $238
  10277a:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  10277f:	e9 3a f6 ff ff       	jmp    101dbe <__alltraps>

00102784 <vector239>:
.globl vector239
vector239:
  pushl $0
  102784:	6a 00                	push   $0x0
  pushl $239
  102786:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  10278b:	e9 2e f6 ff ff       	jmp    101dbe <__alltraps>

00102790 <vector240>:
.globl vector240
vector240:
  pushl $0
  102790:	6a 00                	push   $0x0
  pushl $240
  102792:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  102797:	e9 22 f6 ff ff       	jmp    101dbe <__alltraps>

0010279c <vector241>:
.globl vector241
vector241:
  pushl $0
  10279c:	6a 00                	push   $0x0
  pushl $241
  10279e:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  1027a3:	e9 16 f6 ff ff       	jmp    101dbe <__alltraps>

001027a8 <vector242>:
.globl vector242
vector242:
  pushl $0
  1027a8:	6a 00                	push   $0x0
  pushl $242
  1027aa:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  1027af:	e9 0a f6 ff ff       	jmp    101dbe <__alltraps>

001027b4 <vector243>:
.globl vector243
vector243:
  pushl $0
  1027b4:	6a 00                	push   $0x0
  pushl $243
  1027b6:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1027bb:	e9 fe f5 ff ff       	jmp    101dbe <__alltraps>

001027c0 <vector244>:
.globl vector244
vector244:
  pushl $0
  1027c0:	6a 00                	push   $0x0
  pushl $244
  1027c2:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1027c7:	e9 f2 f5 ff ff       	jmp    101dbe <__alltraps>

001027cc <vector245>:
.globl vector245
vector245:
  pushl $0
  1027cc:	6a 00                	push   $0x0
  pushl $245
  1027ce:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1027d3:	e9 e6 f5 ff ff       	jmp    101dbe <__alltraps>

001027d8 <vector246>:
.globl vector246
vector246:
  pushl $0
  1027d8:	6a 00                	push   $0x0
  pushl $246
  1027da:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1027df:	e9 da f5 ff ff       	jmp    101dbe <__alltraps>

001027e4 <vector247>:
.globl vector247
vector247:
  pushl $0
  1027e4:	6a 00                	push   $0x0
  pushl $247
  1027e6:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  1027eb:	e9 ce f5 ff ff       	jmp    101dbe <__alltraps>

001027f0 <vector248>:
.globl vector248
vector248:
  pushl $0
  1027f0:	6a 00                	push   $0x0
  pushl $248
  1027f2:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  1027f7:	e9 c2 f5 ff ff       	jmp    101dbe <__alltraps>

001027fc <vector249>:
.globl vector249
vector249:
  pushl $0
  1027fc:	6a 00                	push   $0x0
  pushl $249
  1027fe:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102803:	e9 b6 f5 ff ff       	jmp    101dbe <__alltraps>

00102808 <vector250>:
.globl vector250
vector250:
  pushl $0
  102808:	6a 00                	push   $0x0
  pushl $250
  10280a:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  10280f:	e9 aa f5 ff ff       	jmp    101dbe <__alltraps>

00102814 <vector251>:
.globl vector251
vector251:
  pushl $0
  102814:	6a 00                	push   $0x0
  pushl $251
  102816:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  10281b:	e9 9e f5 ff ff       	jmp    101dbe <__alltraps>

00102820 <vector252>:
.globl vector252
vector252:
  pushl $0
  102820:	6a 00                	push   $0x0
  pushl $252
  102822:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  102827:	e9 92 f5 ff ff       	jmp    101dbe <__alltraps>

0010282c <vector253>:
.globl vector253
vector253:
  pushl $0
  10282c:	6a 00                	push   $0x0
  pushl $253
  10282e:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102833:	e9 86 f5 ff ff       	jmp    101dbe <__alltraps>

00102838 <vector254>:
.globl vector254
vector254:
  pushl $0
  102838:	6a 00                	push   $0x0
  pushl $254
  10283a:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  10283f:	e9 7a f5 ff ff       	jmp    101dbe <__alltraps>

00102844 <vector255>:
.globl vector255
vector255:
  pushl $0
  102844:	6a 00                	push   $0x0
  pushl $255
  102846:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  10284b:	e9 6e f5 ff ff       	jmp    101dbe <__alltraps>

00102850 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102850:	55                   	push   %ebp
  102851:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  102853:	8b 45 08             	mov    0x8(%ebp),%eax
  102856:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102859:	b8 23 00 00 00       	mov    $0x23,%eax
  10285e:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102860:	b8 23 00 00 00       	mov    $0x23,%eax
  102865:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  102867:	b8 10 00 00 00       	mov    $0x10,%eax
  10286c:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  10286e:	b8 10 00 00 00       	mov    $0x10,%eax
  102873:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  102875:	b8 10 00 00 00       	mov    $0x10,%eax
  10287a:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  10287c:	ea 83 28 10 00 08 00 	ljmp   $0x8,$0x102883
}
  102883:	5d                   	pop    %ebp
  102884:	c3                   	ret    

00102885 <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  102885:	55                   	push   %ebp
  102886:	89 e5                	mov    %esp,%ebp
  102888:	83 ec 14             	sub    $0x14,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  10288b:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  102890:	05 00 04 00 00       	add    $0x400,%eax
  102895:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  10289a:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  1028a1:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  1028a3:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  1028aa:	68 00 
  1028ac:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1028b1:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  1028b7:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1028bc:	c1 e8 10             	shr    $0x10,%eax
  1028bf:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  1028c4:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1028cb:	83 e0 f0             	and    $0xfffffff0,%eax
  1028ce:	83 c8 09             	or     $0x9,%eax
  1028d1:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1028d6:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1028dd:	83 c8 10             	or     $0x10,%eax
  1028e0:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1028e5:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1028ec:	83 e0 9f             	and    $0xffffff9f,%eax
  1028ef:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  1028f4:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  1028fb:	83 c8 80             	or     $0xffffff80,%eax
  1028fe:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  102903:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  10290a:	83 e0 f0             	and    $0xfffffff0,%eax
  10290d:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102912:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102919:	83 e0 ef             	and    $0xffffffef,%eax
  10291c:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102921:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102928:	83 e0 df             	and    $0xffffffdf,%eax
  10292b:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102930:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102937:	83 c8 40             	or     $0x40,%eax
  10293a:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  10293f:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102946:	83 e0 7f             	and    $0x7f,%eax
  102949:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  10294e:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  102953:	c1 e8 18             	shr    $0x18,%eax
  102956:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  10295b:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102962:	83 e0 ef             	and    $0xffffffef,%eax
  102965:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  10296a:	c7 04 24 10 ea 10 00 	movl   $0x10ea10,(%esp)
  102971:	e8 da fe ff ff       	call   102850 <lgdt>
  102976:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
    asm volatile ("cli");
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  10297c:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  102980:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  102983:	c9                   	leave  
  102984:	c3                   	ret    

00102985 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  102985:	55                   	push   %ebp
  102986:	89 e5                	mov    %esp,%ebp
    gdt_init();
  102988:	e8 f8 fe ff ff       	call   102885 <gdt_init>
}
  10298d:	5d                   	pop    %ebp
  10298e:	c3                   	ret    

0010298f <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  10298f:	55                   	push   %ebp
  102990:	89 e5                	mov    %esp,%ebp
  102992:	83 ec 58             	sub    $0x58,%esp
  102995:	8b 45 10             	mov    0x10(%ebp),%eax
  102998:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10299b:	8b 45 14             	mov    0x14(%ebp),%eax
  10299e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  1029a1:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1029a4:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1029a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1029aa:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  1029ad:	8b 45 18             	mov    0x18(%ebp),%eax
  1029b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1029b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1029b6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1029b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1029bc:	89 55 f0             	mov    %edx,-0x10(%ebp)
  1029bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1029c5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  1029c9:	74 1c                	je     1029e7 <printnum+0x58>
  1029cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029ce:	ba 00 00 00 00       	mov    $0x0,%edx
  1029d3:	f7 75 e4             	divl   -0x1c(%ebp)
  1029d6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  1029d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1029dc:	ba 00 00 00 00       	mov    $0x0,%edx
  1029e1:	f7 75 e4             	divl   -0x1c(%ebp)
  1029e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1029e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1029ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1029ed:	f7 75 e4             	divl   -0x1c(%ebp)
  1029f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1029f3:	89 55 dc             	mov    %edx,-0x24(%ebp)
  1029f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1029f9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1029fc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1029ff:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102a02:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102a05:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102a08:	8b 45 18             	mov    0x18(%ebp),%eax
  102a0b:	ba 00 00 00 00       	mov    $0x0,%edx
  102a10:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102a13:	77 56                	ja     102a6b <printnum+0xdc>
  102a15:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102a18:	72 05                	jb     102a1f <printnum+0x90>
  102a1a:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  102a1d:	77 4c                	ja     102a6b <printnum+0xdc>
        printnum(putch, putdat, result, base, width - 1, padc);
  102a1f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102a22:	8d 50 ff             	lea    -0x1(%eax),%edx
  102a25:	8b 45 20             	mov    0x20(%ebp),%eax
  102a28:	89 44 24 18          	mov    %eax,0x18(%esp)
  102a2c:	89 54 24 14          	mov    %edx,0x14(%esp)
  102a30:	8b 45 18             	mov    0x18(%ebp),%eax
  102a33:	89 44 24 10          	mov    %eax,0x10(%esp)
  102a37:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102a3a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102a3d:	89 44 24 08          	mov    %eax,0x8(%esp)
  102a41:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102a45:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a48:	89 44 24 04          	mov    %eax,0x4(%esp)
  102a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  102a4f:	89 04 24             	mov    %eax,(%esp)
  102a52:	e8 38 ff ff ff       	call   10298f <printnum>
  102a57:	eb 1c                	jmp    102a75 <printnum+0xe6>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102a59:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a5c:	89 44 24 04          	mov    %eax,0x4(%esp)
  102a60:	8b 45 20             	mov    0x20(%ebp),%eax
  102a63:	89 04 24             	mov    %eax,(%esp)
  102a66:	8b 45 08             	mov    0x8(%ebp),%eax
  102a69:	ff d0                	call   *%eax
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  102a6b:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  102a6f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102a73:	7f e4                	jg     102a59 <printnum+0xca>
            putch(padc, putdat);
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102a75:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102a78:	05 90 3c 10 00       	add    $0x103c90,%eax
  102a7d:	0f b6 00             	movzbl (%eax),%eax
  102a80:	0f be c0             	movsbl %al,%eax
  102a83:	8b 55 0c             	mov    0xc(%ebp),%edx
  102a86:	89 54 24 04          	mov    %edx,0x4(%esp)
  102a8a:	89 04 24             	mov    %eax,(%esp)
  102a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  102a90:	ff d0                	call   *%eax
}
  102a92:	c9                   	leave  
  102a93:	c3                   	ret    

00102a94 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102a94:	55                   	push   %ebp
  102a95:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102a97:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102a9b:	7e 14                	jle    102ab1 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  102aa0:	8b 00                	mov    (%eax),%eax
  102aa2:	8d 48 08             	lea    0x8(%eax),%ecx
  102aa5:	8b 55 08             	mov    0x8(%ebp),%edx
  102aa8:	89 0a                	mov    %ecx,(%edx)
  102aaa:	8b 50 04             	mov    0x4(%eax),%edx
  102aad:	8b 00                	mov    (%eax),%eax
  102aaf:	eb 30                	jmp    102ae1 <getuint+0x4d>
    }
    else if (lflag) {
  102ab1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102ab5:	74 16                	je     102acd <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  102aba:	8b 00                	mov    (%eax),%eax
  102abc:	8d 48 04             	lea    0x4(%eax),%ecx
  102abf:	8b 55 08             	mov    0x8(%ebp),%edx
  102ac2:	89 0a                	mov    %ecx,(%edx)
  102ac4:	8b 00                	mov    (%eax),%eax
  102ac6:	ba 00 00 00 00       	mov    $0x0,%edx
  102acb:	eb 14                	jmp    102ae1 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102acd:	8b 45 08             	mov    0x8(%ebp),%eax
  102ad0:	8b 00                	mov    (%eax),%eax
  102ad2:	8d 48 04             	lea    0x4(%eax),%ecx
  102ad5:	8b 55 08             	mov    0x8(%ebp),%edx
  102ad8:	89 0a                	mov    %ecx,(%edx)
  102ada:	8b 00                	mov    (%eax),%eax
  102adc:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102ae1:	5d                   	pop    %ebp
  102ae2:	c3                   	ret    

00102ae3 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102ae3:	55                   	push   %ebp
  102ae4:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102ae6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102aea:	7e 14                	jle    102b00 <getint+0x1d>
        return va_arg(*ap, long long);
  102aec:	8b 45 08             	mov    0x8(%ebp),%eax
  102aef:	8b 00                	mov    (%eax),%eax
  102af1:	8d 48 08             	lea    0x8(%eax),%ecx
  102af4:	8b 55 08             	mov    0x8(%ebp),%edx
  102af7:	89 0a                	mov    %ecx,(%edx)
  102af9:	8b 50 04             	mov    0x4(%eax),%edx
  102afc:	8b 00                	mov    (%eax),%eax
  102afe:	eb 28                	jmp    102b28 <getint+0x45>
    }
    else if (lflag) {
  102b00:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102b04:	74 12                	je     102b18 <getint+0x35>
        return va_arg(*ap, long);
  102b06:	8b 45 08             	mov    0x8(%ebp),%eax
  102b09:	8b 00                	mov    (%eax),%eax
  102b0b:	8d 48 04             	lea    0x4(%eax),%ecx
  102b0e:	8b 55 08             	mov    0x8(%ebp),%edx
  102b11:	89 0a                	mov    %ecx,(%edx)
  102b13:	8b 00                	mov    (%eax),%eax
  102b15:	99                   	cltd   
  102b16:	eb 10                	jmp    102b28 <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102b18:	8b 45 08             	mov    0x8(%ebp),%eax
  102b1b:	8b 00                	mov    (%eax),%eax
  102b1d:	8d 48 04             	lea    0x4(%eax),%ecx
  102b20:	8b 55 08             	mov    0x8(%ebp),%edx
  102b23:	89 0a                	mov    %ecx,(%edx)
  102b25:	8b 00                	mov    (%eax),%eax
  102b27:	99                   	cltd   
    }
}
  102b28:	5d                   	pop    %ebp
  102b29:	c3                   	ret    

00102b2a <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  102b2a:	55                   	push   %ebp
  102b2b:	89 e5                	mov    %esp,%ebp
  102b2d:	83 ec 28             	sub    $0x28,%esp
    va_list ap;

    va_start(ap, fmt);
  102b30:	8d 45 14             	lea    0x14(%ebp),%eax
  102b33:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  102b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102b39:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102b3d:	8b 45 10             	mov    0x10(%ebp),%eax
  102b40:	89 44 24 08          	mov    %eax,0x8(%esp)
  102b44:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b47:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  102b4e:	89 04 24             	mov    %eax,(%esp)
  102b51:	e8 02 00 00 00       	call   102b58 <vprintfmt>
    va_end(ap);
}
  102b56:	c9                   	leave  
  102b57:	c3                   	ret    

00102b58 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  102b58:	55                   	push   %ebp
  102b59:	89 e5                	mov    %esp,%ebp
  102b5b:	56                   	push   %esi
  102b5c:	53                   	push   %ebx
  102b5d:	83 ec 40             	sub    $0x40,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102b60:	eb 18                	jmp    102b7a <vprintfmt+0x22>
            if (ch == '\0') {
  102b62:	85 db                	test   %ebx,%ebx
  102b64:	75 05                	jne    102b6b <vprintfmt+0x13>
                return;
  102b66:	e9 d1 03 00 00       	jmp    102f3c <vprintfmt+0x3e4>
            }
            putch(ch, putdat);
  102b6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b6e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102b72:	89 1c 24             	mov    %ebx,(%esp)
  102b75:	8b 45 08             	mov    0x8(%ebp),%eax
  102b78:	ff d0                	call   *%eax
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102b7a:	8b 45 10             	mov    0x10(%ebp),%eax
  102b7d:	8d 50 01             	lea    0x1(%eax),%edx
  102b80:	89 55 10             	mov    %edx,0x10(%ebp)
  102b83:	0f b6 00             	movzbl (%eax),%eax
  102b86:	0f b6 d8             	movzbl %al,%ebx
  102b89:	83 fb 25             	cmp    $0x25,%ebx
  102b8c:	75 d4                	jne    102b62 <vprintfmt+0xa>
            }
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
  102b8e:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  102b92:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  102b99:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102b9c:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  102b9f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  102ba6:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102ba9:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  102bac:	8b 45 10             	mov    0x10(%ebp),%eax
  102baf:	8d 50 01             	lea    0x1(%eax),%edx
  102bb2:	89 55 10             	mov    %edx,0x10(%ebp)
  102bb5:	0f b6 00             	movzbl (%eax),%eax
  102bb8:	0f b6 d8             	movzbl %al,%ebx
  102bbb:	8d 43 dd             	lea    -0x23(%ebx),%eax
  102bbe:	83 f8 55             	cmp    $0x55,%eax
  102bc1:	0f 87 44 03 00 00    	ja     102f0b <vprintfmt+0x3b3>
  102bc7:	8b 04 85 b4 3c 10 00 	mov    0x103cb4(,%eax,4),%eax
  102bce:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  102bd0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  102bd4:	eb d6                	jmp    102bac <vprintfmt+0x54>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  102bd6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  102bda:	eb d0                	jmp    102bac <vprintfmt+0x54>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102bdc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  102be3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102be6:	89 d0                	mov    %edx,%eax
  102be8:	c1 e0 02             	shl    $0x2,%eax
  102beb:	01 d0                	add    %edx,%eax
  102bed:	01 c0                	add    %eax,%eax
  102bef:	01 d8                	add    %ebx,%eax
  102bf1:	83 e8 30             	sub    $0x30,%eax
  102bf4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  102bf7:	8b 45 10             	mov    0x10(%ebp),%eax
  102bfa:	0f b6 00             	movzbl (%eax),%eax
  102bfd:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  102c00:	83 fb 2f             	cmp    $0x2f,%ebx
  102c03:	7e 0b                	jle    102c10 <vprintfmt+0xb8>
  102c05:	83 fb 39             	cmp    $0x39,%ebx
  102c08:	7f 06                	jg     102c10 <vprintfmt+0xb8>
            padc = '0';
            goto reswitch;

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  102c0a:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                precision = precision * 10 + ch - '0';
                ch = *fmt;
                if (ch < '0' || ch > '9') {
                    break;
                }
            }
  102c0e:	eb d3                	jmp    102be3 <vprintfmt+0x8b>
            goto process_precision;
  102c10:	eb 33                	jmp    102c45 <vprintfmt+0xed>

        case '*':
            precision = va_arg(ap, int);
  102c12:	8b 45 14             	mov    0x14(%ebp),%eax
  102c15:	8d 50 04             	lea    0x4(%eax),%edx
  102c18:	89 55 14             	mov    %edx,0x14(%ebp)
  102c1b:	8b 00                	mov    (%eax),%eax
  102c1d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  102c20:	eb 23                	jmp    102c45 <vprintfmt+0xed>

        case '.':
            if (width < 0)
  102c22:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102c26:	79 0c                	jns    102c34 <vprintfmt+0xdc>
                width = 0;
  102c28:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  102c2f:	e9 78 ff ff ff       	jmp    102bac <vprintfmt+0x54>
  102c34:	e9 73 ff ff ff       	jmp    102bac <vprintfmt+0x54>

        case '#':
            altflag = 1;
  102c39:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  102c40:	e9 67 ff ff ff       	jmp    102bac <vprintfmt+0x54>

        process_precision:
            if (width < 0)
  102c45:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102c49:	79 12                	jns    102c5d <vprintfmt+0x105>
                width = precision, precision = -1;
  102c4b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102c4e:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102c51:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  102c58:	e9 4f ff ff ff       	jmp    102bac <vprintfmt+0x54>
  102c5d:	e9 4a ff ff ff       	jmp    102bac <vprintfmt+0x54>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  102c62:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  102c66:	e9 41 ff ff ff       	jmp    102bac <vprintfmt+0x54>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  102c6b:	8b 45 14             	mov    0x14(%ebp),%eax
  102c6e:	8d 50 04             	lea    0x4(%eax),%edx
  102c71:	89 55 14             	mov    %edx,0x14(%ebp)
  102c74:	8b 00                	mov    (%eax),%eax
  102c76:	8b 55 0c             	mov    0xc(%ebp),%edx
  102c79:	89 54 24 04          	mov    %edx,0x4(%esp)
  102c7d:	89 04 24             	mov    %eax,(%esp)
  102c80:	8b 45 08             	mov    0x8(%ebp),%eax
  102c83:	ff d0                	call   *%eax
            break;
  102c85:	e9 ac 02 00 00       	jmp    102f36 <vprintfmt+0x3de>

        // error message
        case 'e':
            err = va_arg(ap, int);
  102c8a:	8b 45 14             	mov    0x14(%ebp),%eax
  102c8d:	8d 50 04             	lea    0x4(%eax),%edx
  102c90:	89 55 14             	mov    %edx,0x14(%ebp)
  102c93:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  102c95:	85 db                	test   %ebx,%ebx
  102c97:	79 02                	jns    102c9b <vprintfmt+0x143>
                err = -err;
  102c99:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  102c9b:	83 fb 06             	cmp    $0x6,%ebx
  102c9e:	7f 0b                	jg     102cab <vprintfmt+0x153>
  102ca0:	8b 34 9d 74 3c 10 00 	mov    0x103c74(,%ebx,4),%esi
  102ca7:	85 f6                	test   %esi,%esi
  102ca9:	75 23                	jne    102cce <vprintfmt+0x176>
                printfmt(putch, putdat, "error %d", err);
  102cab:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  102caf:	c7 44 24 08 a1 3c 10 	movl   $0x103ca1,0x8(%esp)
  102cb6:	00 
  102cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cba:	89 44 24 04          	mov    %eax,0x4(%esp)
  102cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  102cc1:	89 04 24             	mov    %eax,(%esp)
  102cc4:	e8 61 fe ff ff       	call   102b2a <printfmt>
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  102cc9:	e9 68 02 00 00       	jmp    102f36 <vprintfmt+0x3de>
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
                printfmt(putch, putdat, "error %d", err);
            }
            else {
                printfmt(putch, putdat, "%s", p);
  102cce:	89 74 24 0c          	mov    %esi,0xc(%esp)
  102cd2:	c7 44 24 08 aa 3c 10 	movl   $0x103caa,0x8(%esp)
  102cd9:	00 
  102cda:	8b 45 0c             	mov    0xc(%ebp),%eax
  102cdd:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  102ce4:	89 04 24             	mov    %eax,(%esp)
  102ce7:	e8 3e fe ff ff       	call   102b2a <printfmt>
            }
            break;
  102cec:	e9 45 02 00 00       	jmp    102f36 <vprintfmt+0x3de>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  102cf1:	8b 45 14             	mov    0x14(%ebp),%eax
  102cf4:	8d 50 04             	lea    0x4(%eax),%edx
  102cf7:	89 55 14             	mov    %edx,0x14(%ebp)
  102cfa:	8b 30                	mov    (%eax),%esi
  102cfc:	85 f6                	test   %esi,%esi
  102cfe:	75 05                	jne    102d05 <vprintfmt+0x1ad>
                p = "(null)";
  102d00:	be ad 3c 10 00       	mov    $0x103cad,%esi
            }
            if (width > 0 && padc != '-') {
  102d05:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102d09:	7e 3e                	jle    102d49 <vprintfmt+0x1f1>
  102d0b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  102d0f:	74 38                	je     102d49 <vprintfmt+0x1f1>
                for (width -= strnlen(p, precision); width > 0; width --) {
  102d11:	8b 5d e8             	mov    -0x18(%ebp),%ebx
  102d14:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  102d17:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d1b:	89 34 24             	mov    %esi,(%esp)
  102d1e:	e8 15 03 00 00       	call   103038 <strnlen>
  102d23:	29 c3                	sub    %eax,%ebx
  102d25:	89 d8                	mov    %ebx,%eax
  102d27:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102d2a:	eb 17                	jmp    102d43 <vprintfmt+0x1eb>
                    putch(padc, putdat);
  102d2c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  102d30:	8b 55 0c             	mov    0xc(%ebp),%edx
  102d33:	89 54 24 04          	mov    %edx,0x4(%esp)
  102d37:	89 04 24             	mov    %eax,(%esp)
  102d3a:	8b 45 08             	mov    0x8(%ebp),%eax
  102d3d:	ff d0                	call   *%eax
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
                p = "(null)";
            }
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
  102d3f:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102d43:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102d47:	7f e3                	jg     102d2c <vprintfmt+0x1d4>
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102d49:	eb 38                	jmp    102d83 <vprintfmt+0x22b>
                if (altflag && (ch < ' ' || ch > '~')) {
  102d4b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  102d4f:	74 1f                	je     102d70 <vprintfmt+0x218>
  102d51:	83 fb 1f             	cmp    $0x1f,%ebx
  102d54:	7e 05                	jle    102d5b <vprintfmt+0x203>
  102d56:	83 fb 7e             	cmp    $0x7e,%ebx
  102d59:	7e 15                	jle    102d70 <vprintfmt+0x218>
                    putch('?', putdat);
  102d5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d5e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d62:	c7 04 24 3f 00 00 00 	movl   $0x3f,(%esp)
  102d69:	8b 45 08             	mov    0x8(%ebp),%eax
  102d6c:	ff d0                	call   *%eax
  102d6e:	eb 0f                	jmp    102d7f <vprintfmt+0x227>
                }
                else {
                    putch(ch, putdat);
  102d70:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d73:	89 44 24 04          	mov    %eax,0x4(%esp)
  102d77:	89 1c 24             	mov    %ebx,(%esp)
  102d7a:	8b 45 08             	mov    0x8(%ebp),%eax
  102d7d:	ff d0                	call   *%eax
            if (width > 0 && padc != '-') {
                for (width -= strnlen(p, precision); width > 0; width --) {
                    putch(padc, putdat);
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  102d7f:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102d83:	89 f0                	mov    %esi,%eax
  102d85:	8d 70 01             	lea    0x1(%eax),%esi
  102d88:	0f b6 00             	movzbl (%eax),%eax
  102d8b:	0f be d8             	movsbl %al,%ebx
  102d8e:	85 db                	test   %ebx,%ebx
  102d90:	74 10                	je     102da2 <vprintfmt+0x24a>
  102d92:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102d96:	78 b3                	js     102d4b <vprintfmt+0x1f3>
  102d98:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  102d9c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  102da0:	79 a9                	jns    102d4b <vprintfmt+0x1f3>
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102da2:	eb 17                	jmp    102dbb <vprintfmt+0x263>
                putch(' ', putdat);
  102da4:	8b 45 0c             	mov    0xc(%ebp),%eax
  102da7:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dab:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
  102db2:	8b 45 08             	mov    0x8(%ebp),%eax
  102db5:	ff d0                	call   *%eax
                }
                else {
                    putch(ch, putdat);
                }
            }
            for (; width > 0; width --) {
  102db7:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  102dbb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  102dbf:	7f e3                	jg     102da4 <vprintfmt+0x24c>
                putch(' ', putdat);
            }
            break;
  102dc1:	e9 70 01 00 00       	jmp    102f36 <vprintfmt+0x3de>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  102dc6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102dc9:	89 44 24 04          	mov    %eax,0x4(%esp)
  102dcd:	8d 45 14             	lea    0x14(%ebp),%eax
  102dd0:	89 04 24             	mov    %eax,(%esp)
  102dd3:	e8 0b fd ff ff       	call   102ae3 <getint>
  102dd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102ddb:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  102dde:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102de1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102de4:	85 d2                	test   %edx,%edx
  102de6:	79 26                	jns    102e0e <vprintfmt+0x2b6>
                putch('-', putdat);
  102de8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102deb:	89 44 24 04          	mov    %eax,0x4(%esp)
  102def:	c7 04 24 2d 00 00 00 	movl   $0x2d,(%esp)
  102df6:	8b 45 08             	mov    0x8(%ebp),%eax
  102df9:	ff d0                	call   *%eax
                num = -(long long)num;
  102dfb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102dfe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102e01:	f7 d8                	neg    %eax
  102e03:	83 d2 00             	adc    $0x0,%edx
  102e06:	f7 da                	neg    %edx
  102e08:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e0b:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  102e0e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102e15:	e9 a8 00 00 00       	jmp    102ec2 <vprintfmt+0x36a>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  102e1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102e1d:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e21:	8d 45 14             	lea    0x14(%ebp),%eax
  102e24:	89 04 24             	mov    %eax,(%esp)
  102e27:	e8 68 fc ff ff       	call   102a94 <getuint>
  102e2c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e2f:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  102e32:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  102e39:	e9 84 00 00 00       	jmp    102ec2 <vprintfmt+0x36a>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  102e3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102e41:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e45:	8d 45 14             	lea    0x14(%ebp),%eax
  102e48:	89 04 24             	mov    %eax,(%esp)
  102e4b:	e8 44 fc ff ff       	call   102a94 <getuint>
  102e50:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e53:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  102e56:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  102e5d:	eb 63                	jmp    102ec2 <vprintfmt+0x36a>

        // pointer
        case 'p':
            putch('0', putdat);
  102e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e62:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e66:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
  102e6d:	8b 45 08             	mov    0x8(%ebp),%eax
  102e70:	ff d0                	call   *%eax
            putch('x', putdat);
  102e72:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e75:	89 44 24 04          	mov    %eax,0x4(%esp)
  102e79:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
  102e80:	8b 45 08             	mov    0x8(%ebp),%eax
  102e83:	ff d0                	call   *%eax
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  102e85:	8b 45 14             	mov    0x14(%ebp),%eax
  102e88:	8d 50 04             	lea    0x4(%eax),%edx
  102e8b:	89 55 14             	mov    %edx,0x14(%ebp)
  102e8e:	8b 00                	mov    (%eax),%eax
  102e90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102e93:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  102e9a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  102ea1:	eb 1f                	jmp    102ec2 <vprintfmt+0x36a>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  102ea3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ea6:	89 44 24 04          	mov    %eax,0x4(%esp)
  102eaa:	8d 45 14             	lea    0x14(%ebp),%eax
  102ead:	89 04 24             	mov    %eax,(%esp)
  102eb0:	e8 df fb ff ff       	call   102a94 <getuint>
  102eb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102eb8:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  102ebb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  102ec2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  102ec6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102ec9:	89 54 24 18          	mov    %edx,0x18(%esp)
  102ecd:	8b 55 e8             	mov    -0x18(%ebp),%edx
  102ed0:	89 54 24 14          	mov    %edx,0x14(%esp)
  102ed4:	89 44 24 10          	mov    %eax,0x10(%esp)
  102ed8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102edb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ede:	89 44 24 08          	mov    %eax,0x8(%esp)
  102ee2:	89 54 24 0c          	mov    %edx,0xc(%esp)
  102ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ee9:	89 44 24 04          	mov    %eax,0x4(%esp)
  102eed:	8b 45 08             	mov    0x8(%ebp),%eax
  102ef0:	89 04 24             	mov    %eax,(%esp)
  102ef3:	e8 97 fa ff ff       	call   10298f <printnum>
            break;
  102ef8:	eb 3c                	jmp    102f36 <vprintfmt+0x3de>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  102efa:	8b 45 0c             	mov    0xc(%ebp),%eax
  102efd:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f01:	89 1c 24             	mov    %ebx,(%esp)
  102f04:	8b 45 08             	mov    0x8(%ebp),%eax
  102f07:	ff d0                	call   *%eax
            break;
  102f09:	eb 2b                	jmp    102f36 <vprintfmt+0x3de>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  102f0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f0e:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f12:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
  102f19:	8b 45 08             	mov    0x8(%ebp),%eax
  102f1c:	ff d0                	call   *%eax
            for (fmt --; fmt[-1] != '%'; fmt --)
  102f1e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102f22:	eb 04                	jmp    102f28 <vprintfmt+0x3d0>
  102f24:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102f28:	8b 45 10             	mov    0x10(%ebp),%eax
  102f2b:	83 e8 01             	sub    $0x1,%eax
  102f2e:	0f b6 00             	movzbl (%eax),%eax
  102f31:	3c 25                	cmp    $0x25,%al
  102f33:	75 ef                	jne    102f24 <vprintfmt+0x3cc>
                /* do nothing */;
            break;
  102f35:	90                   	nop
        }
    }
  102f36:	90                   	nop
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  102f37:	e9 3e fc ff ff       	jmp    102b7a <vprintfmt+0x22>
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  102f3c:	83 c4 40             	add    $0x40,%esp
  102f3f:	5b                   	pop    %ebx
  102f40:	5e                   	pop    %esi
  102f41:	5d                   	pop    %ebp
  102f42:	c3                   	ret    

00102f43 <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  102f43:	55                   	push   %ebp
  102f44:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  102f46:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f49:	8b 40 08             	mov    0x8(%eax),%eax
  102f4c:	8d 50 01             	lea    0x1(%eax),%edx
  102f4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f52:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  102f55:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f58:	8b 10                	mov    (%eax),%edx
  102f5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f5d:	8b 40 04             	mov    0x4(%eax),%eax
  102f60:	39 c2                	cmp    %eax,%edx
  102f62:	73 12                	jae    102f76 <sprintputch+0x33>
        *b->buf ++ = ch;
  102f64:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f67:	8b 00                	mov    (%eax),%eax
  102f69:	8d 48 01             	lea    0x1(%eax),%ecx
  102f6c:	8b 55 0c             	mov    0xc(%ebp),%edx
  102f6f:	89 0a                	mov    %ecx,(%edx)
  102f71:	8b 55 08             	mov    0x8(%ebp),%edx
  102f74:	88 10                	mov    %dl,(%eax)
    }
}
  102f76:	5d                   	pop    %ebp
  102f77:	c3                   	ret    

00102f78 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  102f78:	55                   	push   %ebp
  102f79:	89 e5                	mov    %esp,%ebp
  102f7b:	83 ec 28             	sub    $0x28,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  102f7e:	8d 45 14             	lea    0x14(%ebp),%eax
  102f81:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  102f84:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102f87:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102f8b:	8b 45 10             	mov    0x10(%ebp),%eax
  102f8e:	89 44 24 08          	mov    %eax,0x8(%esp)
  102f92:	8b 45 0c             	mov    0xc(%ebp),%eax
  102f95:	89 44 24 04          	mov    %eax,0x4(%esp)
  102f99:	8b 45 08             	mov    0x8(%ebp),%eax
  102f9c:	89 04 24             	mov    %eax,(%esp)
  102f9f:	e8 08 00 00 00       	call   102fac <vsnprintf>
  102fa4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  102fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  102faa:	c9                   	leave  
  102fab:	c3                   	ret    

00102fac <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  102fac:	55                   	push   %ebp
  102fad:	89 e5                	mov    %esp,%ebp
  102faf:	83 ec 28             	sub    $0x28,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  102fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  102fb5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102fb8:	8b 45 0c             	mov    0xc(%ebp),%eax
  102fbb:	8d 50 ff             	lea    -0x1(%eax),%edx
  102fbe:	8b 45 08             	mov    0x8(%ebp),%eax
  102fc1:	01 d0                	add    %edx,%eax
  102fc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102fc6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  102fcd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  102fd1:	74 0a                	je     102fdd <vsnprintf+0x31>
  102fd3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102fd6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102fd9:	39 c2                	cmp    %eax,%edx
  102fdb:	76 07                	jbe    102fe4 <vsnprintf+0x38>
        return -E_INVAL;
  102fdd:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  102fe2:	eb 2a                	jmp    10300e <vsnprintf+0x62>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  102fe4:	8b 45 14             	mov    0x14(%ebp),%eax
  102fe7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  102feb:	8b 45 10             	mov    0x10(%ebp),%eax
  102fee:	89 44 24 08          	mov    %eax,0x8(%esp)
  102ff2:	8d 45 ec             	lea    -0x14(%ebp),%eax
  102ff5:	89 44 24 04          	mov    %eax,0x4(%esp)
  102ff9:	c7 04 24 43 2f 10 00 	movl   $0x102f43,(%esp)
  103000:	e8 53 fb ff ff       	call   102b58 <vprintfmt>
    // null terminate the buffer
    *b.buf = '\0';
  103005:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103008:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  10300b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10300e:	c9                   	leave  
  10300f:	c3                   	ret    

00103010 <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  103010:	55                   	push   %ebp
  103011:	89 e5                	mov    %esp,%ebp
  103013:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  103016:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  10301d:	eb 04                	jmp    103023 <strlen+0x13>
        cnt ++;
  10301f:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
  103023:	8b 45 08             	mov    0x8(%ebp),%eax
  103026:	8d 50 01             	lea    0x1(%eax),%edx
  103029:	89 55 08             	mov    %edx,0x8(%ebp)
  10302c:	0f b6 00             	movzbl (%eax),%eax
  10302f:	84 c0                	test   %al,%al
  103031:	75 ec                	jne    10301f <strlen+0xf>
        cnt ++;
    }
    return cnt;
  103033:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  103036:	c9                   	leave  
  103037:	c3                   	ret    

00103038 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  103038:	55                   	push   %ebp
  103039:	89 e5                	mov    %esp,%ebp
  10303b:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  10303e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  103045:	eb 04                	jmp    10304b <strnlen+0x13>
        cnt ++;
  103047:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
    while (cnt < len && *s ++ != '\0') {
  10304b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10304e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  103051:	73 10                	jae    103063 <strnlen+0x2b>
  103053:	8b 45 08             	mov    0x8(%ebp),%eax
  103056:	8d 50 01             	lea    0x1(%eax),%edx
  103059:	89 55 08             	mov    %edx,0x8(%ebp)
  10305c:	0f b6 00             	movzbl (%eax),%eax
  10305f:	84 c0                	test   %al,%al
  103061:	75 e4                	jne    103047 <strnlen+0xf>
        cnt ++;
    }
    return cnt;
  103063:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  103066:	c9                   	leave  
  103067:	c3                   	ret    

00103068 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  103068:	55                   	push   %ebp
  103069:	89 e5                	mov    %esp,%ebp
  10306b:	57                   	push   %edi
  10306c:	56                   	push   %esi
  10306d:	83 ec 20             	sub    $0x20,%esp
  103070:	8b 45 08             	mov    0x8(%ebp),%eax
  103073:	89 45 f4             	mov    %eax,-0xc(%ebp)
  103076:	8b 45 0c             	mov    0xc(%ebp),%eax
  103079:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  10307c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10307f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103082:	89 d1                	mov    %edx,%ecx
  103084:	89 c2                	mov    %eax,%edx
  103086:	89 ce                	mov    %ecx,%esi
  103088:	89 d7                	mov    %edx,%edi
  10308a:	ac                   	lods   %ds:(%esi),%al
  10308b:	aa                   	stos   %al,%es:(%edi)
  10308c:	84 c0                	test   %al,%al
  10308e:	75 fa                	jne    10308a <strcpy+0x22>
  103090:	89 fa                	mov    %edi,%edx
  103092:	89 f1                	mov    %esi,%ecx
  103094:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  103097:	89 55 e8             	mov    %edx,-0x18(%ebp)
  10309a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  10309d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  1030a0:	83 c4 20             	add    $0x20,%esp
  1030a3:	5e                   	pop    %esi
  1030a4:	5f                   	pop    %edi
  1030a5:	5d                   	pop    %ebp
  1030a6:	c3                   	ret    

001030a7 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  1030a7:	55                   	push   %ebp
  1030a8:	89 e5                	mov    %esp,%ebp
  1030aa:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  1030ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1030b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  1030b3:	eb 21                	jmp    1030d6 <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  1030b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030b8:	0f b6 10             	movzbl (%eax),%edx
  1030bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1030be:	88 10                	mov    %dl,(%eax)
  1030c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1030c3:	0f b6 00             	movzbl (%eax),%eax
  1030c6:	84 c0                	test   %al,%al
  1030c8:	74 04                	je     1030ce <strncpy+0x27>
            src ++;
  1030ca:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  1030ce:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1030d2:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
    char *p = dst;
    while (len > 0) {
  1030d6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  1030da:	75 d9                	jne    1030b5 <strncpy+0xe>
        if ((*p = *src) != '\0') {
            src ++;
        }
        p ++, len --;
    }
    return dst;
  1030dc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1030df:	c9                   	leave  
  1030e0:	c3                   	ret    

001030e1 <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  1030e1:	55                   	push   %ebp
  1030e2:	89 e5                	mov    %esp,%ebp
  1030e4:	57                   	push   %edi
  1030e5:	56                   	push   %esi
  1030e6:	83 ec 20             	sub    $0x20,%esp
  1030e9:	8b 45 08             	mov    0x8(%ebp),%eax
  1030ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1030ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  1030f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCMP
#define __HAVE_ARCH_STRCMP
static inline int
__strcmp(const char *s1, const char *s2) {
    int d0, d1, ret;
    asm volatile (
  1030f5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1030f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1030fb:	89 d1                	mov    %edx,%ecx
  1030fd:	89 c2                	mov    %eax,%edx
  1030ff:	89 ce                	mov    %ecx,%esi
  103101:	89 d7                	mov    %edx,%edi
  103103:	ac                   	lods   %ds:(%esi),%al
  103104:	ae                   	scas   %es:(%edi),%al
  103105:	75 08                	jne    10310f <strcmp+0x2e>
  103107:	84 c0                	test   %al,%al
  103109:	75 f8                	jne    103103 <strcmp+0x22>
  10310b:	31 c0                	xor    %eax,%eax
  10310d:	eb 04                	jmp    103113 <strcmp+0x32>
  10310f:	19 c0                	sbb    %eax,%eax
  103111:	0c 01                	or     $0x1,%al
  103113:	89 fa                	mov    %edi,%edx
  103115:	89 f1                	mov    %esi,%ecx
  103117:	89 45 ec             	mov    %eax,-0x14(%ebp)
  10311a:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  10311d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
            "orb $1, %%al;"
            "3:"
            : "=a" (ret), "=&S" (d0), "=&D" (d1)
            : "1" (s1), "2" (s2)
            : "memory");
    return ret;
  103120:	8b 45 ec             	mov    -0x14(%ebp),%eax
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  103123:	83 c4 20             	add    $0x20,%esp
  103126:	5e                   	pop    %esi
  103127:	5f                   	pop    %edi
  103128:	5d                   	pop    %ebp
  103129:	c3                   	ret    

0010312a <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  10312a:	55                   	push   %ebp
  10312b:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  10312d:	eb 0c                	jmp    10313b <strncmp+0x11>
        n --, s1 ++, s2 ++;
  10312f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  103133:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103137:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  10313b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10313f:	74 1a                	je     10315b <strncmp+0x31>
  103141:	8b 45 08             	mov    0x8(%ebp),%eax
  103144:	0f b6 00             	movzbl (%eax),%eax
  103147:	84 c0                	test   %al,%al
  103149:	74 10                	je     10315b <strncmp+0x31>
  10314b:	8b 45 08             	mov    0x8(%ebp),%eax
  10314e:	0f b6 10             	movzbl (%eax),%edx
  103151:	8b 45 0c             	mov    0xc(%ebp),%eax
  103154:	0f b6 00             	movzbl (%eax),%eax
  103157:	38 c2                	cmp    %al,%dl
  103159:	74 d4                	je     10312f <strncmp+0x5>
        n --, s1 ++, s2 ++;
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  10315b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  10315f:	74 18                	je     103179 <strncmp+0x4f>
  103161:	8b 45 08             	mov    0x8(%ebp),%eax
  103164:	0f b6 00             	movzbl (%eax),%eax
  103167:	0f b6 d0             	movzbl %al,%edx
  10316a:	8b 45 0c             	mov    0xc(%ebp),%eax
  10316d:	0f b6 00             	movzbl (%eax),%eax
  103170:	0f b6 c0             	movzbl %al,%eax
  103173:	29 c2                	sub    %eax,%edx
  103175:	89 d0                	mov    %edx,%eax
  103177:	eb 05                	jmp    10317e <strncmp+0x54>
  103179:	b8 00 00 00 00       	mov    $0x0,%eax
}
  10317e:	5d                   	pop    %ebp
  10317f:	c3                   	ret    

00103180 <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  103180:	55                   	push   %ebp
  103181:	89 e5                	mov    %esp,%ebp
  103183:	83 ec 04             	sub    $0x4,%esp
  103186:	8b 45 0c             	mov    0xc(%ebp),%eax
  103189:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  10318c:	eb 14                	jmp    1031a2 <strchr+0x22>
        if (*s == c) {
  10318e:	8b 45 08             	mov    0x8(%ebp),%eax
  103191:	0f b6 00             	movzbl (%eax),%eax
  103194:	3a 45 fc             	cmp    -0x4(%ebp),%al
  103197:	75 05                	jne    10319e <strchr+0x1e>
            return (char *)s;
  103199:	8b 45 08             	mov    0x8(%ebp),%eax
  10319c:	eb 13                	jmp    1031b1 <strchr+0x31>
        }
        s ++;
  10319e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
  1031a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1031a5:	0f b6 00             	movzbl (%eax),%eax
  1031a8:	84 c0                	test   %al,%al
  1031aa:	75 e2                	jne    10318e <strchr+0xe>
        if (*s == c) {
            return (char *)s;
        }
        s ++;
    }
    return NULL;
  1031ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1031b1:	c9                   	leave  
  1031b2:	c3                   	ret    

001031b3 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  1031b3:	55                   	push   %ebp
  1031b4:	89 e5                	mov    %esp,%ebp
  1031b6:	83 ec 04             	sub    $0x4,%esp
  1031b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  1031bc:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  1031bf:	eb 11                	jmp    1031d2 <strfind+0x1f>
        if (*s == c) {
  1031c1:	8b 45 08             	mov    0x8(%ebp),%eax
  1031c4:	0f b6 00             	movzbl (%eax),%eax
  1031c7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  1031ca:	75 02                	jne    1031ce <strfind+0x1b>
            break;
  1031cc:	eb 0e                	jmp    1031dc <strfind+0x29>
        }
        s ++;
  1031ce:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
    while (*s != '\0') {
  1031d2:	8b 45 08             	mov    0x8(%ebp),%eax
  1031d5:	0f b6 00             	movzbl (%eax),%eax
  1031d8:	84 c0                	test   %al,%al
  1031da:	75 e5                	jne    1031c1 <strfind+0xe>
        if (*s == c) {
            break;
        }
        s ++;
    }
    return (char *)s;
  1031dc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  1031df:	c9                   	leave  
  1031e0:	c3                   	ret    

001031e1 <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  1031e1:	55                   	push   %ebp
  1031e2:	89 e5                	mov    %esp,%ebp
  1031e4:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  1031e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  1031ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1031f5:	eb 04                	jmp    1031fb <strtol+0x1a>
        s ++;
  1031f7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
strtol(const char *s, char **endptr, int base) {
    int neg = 0;
    long val = 0;

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  1031fb:	8b 45 08             	mov    0x8(%ebp),%eax
  1031fe:	0f b6 00             	movzbl (%eax),%eax
  103201:	3c 20                	cmp    $0x20,%al
  103203:	74 f2                	je     1031f7 <strtol+0x16>
  103205:	8b 45 08             	mov    0x8(%ebp),%eax
  103208:	0f b6 00             	movzbl (%eax),%eax
  10320b:	3c 09                	cmp    $0x9,%al
  10320d:	74 e8                	je     1031f7 <strtol+0x16>
        s ++;
    }

    // plus/minus sign
    if (*s == '+') {
  10320f:	8b 45 08             	mov    0x8(%ebp),%eax
  103212:	0f b6 00             	movzbl (%eax),%eax
  103215:	3c 2b                	cmp    $0x2b,%al
  103217:	75 06                	jne    10321f <strtol+0x3e>
        s ++;
  103219:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10321d:	eb 15                	jmp    103234 <strtol+0x53>
    }
    else if (*s == '-') {
  10321f:	8b 45 08             	mov    0x8(%ebp),%eax
  103222:	0f b6 00             	movzbl (%eax),%eax
  103225:	3c 2d                	cmp    $0x2d,%al
  103227:	75 0b                	jne    103234 <strtol+0x53>
        s ++, neg = 1;
  103229:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  10322d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  103234:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103238:	74 06                	je     103240 <strtol+0x5f>
  10323a:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  10323e:	75 24                	jne    103264 <strtol+0x83>
  103240:	8b 45 08             	mov    0x8(%ebp),%eax
  103243:	0f b6 00             	movzbl (%eax),%eax
  103246:	3c 30                	cmp    $0x30,%al
  103248:	75 1a                	jne    103264 <strtol+0x83>
  10324a:	8b 45 08             	mov    0x8(%ebp),%eax
  10324d:	83 c0 01             	add    $0x1,%eax
  103250:	0f b6 00             	movzbl (%eax),%eax
  103253:	3c 78                	cmp    $0x78,%al
  103255:	75 0d                	jne    103264 <strtol+0x83>
        s += 2, base = 16;
  103257:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  10325b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  103262:	eb 2a                	jmp    10328e <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  103264:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103268:	75 17                	jne    103281 <strtol+0xa0>
  10326a:	8b 45 08             	mov    0x8(%ebp),%eax
  10326d:	0f b6 00             	movzbl (%eax),%eax
  103270:	3c 30                	cmp    $0x30,%al
  103272:	75 0d                	jne    103281 <strtol+0xa0>
        s ++, base = 8;
  103274:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103278:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  10327f:	eb 0d                	jmp    10328e <strtol+0xad>
    }
    else if (base == 0) {
  103281:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  103285:	75 07                	jne    10328e <strtol+0xad>
        base = 10;
  103287:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  10328e:	8b 45 08             	mov    0x8(%ebp),%eax
  103291:	0f b6 00             	movzbl (%eax),%eax
  103294:	3c 2f                	cmp    $0x2f,%al
  103296:	7e 1b                	jle    1032b3 <strtol+0xd2>
  103298:	8b 45 08             	mov    0x8(%ebp),%eax
  10329b:	0f b6 00             	movzbl (%eax),%eax
  10329e:	3c 39                	cmp    $0x39,%al
  1032a0:	7f 11                	jg     1032b3 <strtol+0xd2>
            dig = *s - '0';
  1032a2:	8b 45 08             	mov    0x8(%ebp),%eax
  1032a5:	0f b6 00             	movzbl (%eax),%eax
  1032a8:	0f be c0             	movsbl %al,%eax
  1032ab:	83 e8 30             	sub    $0x30,%eax
  1032ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1032b1:	eb 48                	jmp    1032fb <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  1032b3:	8b 45 08             	mov    0x8(%ebp),%eax
  1032b6:	0f b6 00             	movzbl (%eax),%eax
  1032b9:	3c 60                	cmp    $0x60,%al
  1032bb:	7e 1b                	jle    1032d8 <strtol+0xf7>
  1032bd:	8b 45 08             	mov    0x8(%ebp),%eax
  1032c0:	0f b6 00             	movzbl (%eax),%eax
  1032c3:	3c 7a                	cmp    $0x7a,%al
  1032c5:	7f 11                	jg     1032d8 <strtol+0xf7>
            dig = *s - 'a' + 10;
  1032c7:	8b 45 08             	mov    0x8(%ebp),%eax
  1032ca:	0f b6 00             	movzbl (%eax),%eax
  1032cd:	0f be c0             	movsbl %al,%eax
  1032d0:	83 e8 57             	sub    $0x57,%eax
  1032d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1032d6:	eb 23                	jmp    1032fb <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  1032d8:	8b 45 08             	mov    0x8(%ebp),%eax
  1032db:	0f b6 00             	movzbl (%eax),%eax
  1032de:	3c 40                	cmp    $0x40,%al
  1032e0:	7e 3d                	jle    10331f <strtol+0x13e>
  1032e2:	8b 45 08             	mov    0x8(%ebp),%eax
  1032e5:	0f b6 00             	movzbl (%eax),%eax
  1032e8:	3c 5a                	cmp    $0x5a,%al
  1032ea:	7f 33                	jg     10331f <strtol+0x13e>
            dig = *s - 'A' + 10;
  1032ec:	8b 45 08             	mov    0x8(%ebp),%eax
  1032ef:	0f b6 00             	movzbl (%eax),%eax
  1032f2:	0f be c0             	movsbl %al,%eax
  1032f5:	83 e8 37             	sub    $0x37,%eax
  1032f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  1032fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1032fe:	3b 45 10             	cmp    0x10(%ebp),%eax
  103301:	7c 02                	jl     103305 <strtol+0x124>
            break;
  103303:	eb 1a                	jmp    10331f <strtol+0x13e>
        }
        s ++, val = (val * base) + dig;
  103305:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  103309:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10330c:	0f af 45 10          	imul   0x10(%ebp),%eax
  103310:	89 c2                	mov    %eax,%edx
  103312:	8b 45 f4             	mov    -0xc(%ebp),%eax
  103315:	01 d0                	add    %edx,%eax
  103317:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  10331a:	e9 6f ff ff ff       	jmp    10328e <strtol+0xad>

    if (endptr) {
  10331f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  103323:	74 08                	je     10332d <strtol+0x14c>
        *endptr = (char *) s;
  103325:	8b 45 0c             	mov    0xc(%ebp),%eax
  103328:	8b 55 08             	mov    0x8(%ebp),%edx
  10332b:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  10332d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  103331:	74 07                	je     10333a <strtol+0x159>
  103333:	8b 45 f8             	mov    -0x8(%ebp),%eax
  103336:	f7 d8                	neg    %eax
  103338:	eb 03                	jmp    10333d <strtol+0x15c>
  10333a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  10333d:	c9                   	leave  
  10333e:	c3                   	ret    

0010333f <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  10333f:	55                   	push   %ebp
  103340:	89 e5                	mov    %esp,%ebp
  103342:	57                   	push   %edi
  103343:	83 ec 24             	sub    $0x24,%esp
  103346:	8b 45 0c             	mov    0xc(%ebp),%eax
  103349:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  10334c:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  103350:	8b 55 08             	mov    0x8(%ebp),%edx
  103353:	89 55 f8             	mov    %edx,-0x8(%ebp)
  103356:	88 45 f7             	mov    %al,-0x9(%ebp)
  103359:	8b 45 10             	mov    0x10(%ebp),%eax
  10335c:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  10335f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  103362:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  103366:	8b 55 f8             	mov    -0x8(%ebp),%edx
  103369:	89 d7                	mov    %edx,%edi
  10336b:	f3 aa                	rep stos %al,%es:(%edi)
  10336d:	89 fa                	mov    %edi,%edx
  10336f:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  103372:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  103375:	8b 45 f8             	mov    -0x8(%ebp),%eax
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  103378:	83 c4 24             	add    $0x24,%esp
  10337b:	5f                   	pop    %edi
  10337c:	5d                   	pop    %ebp
  10337d:	c3                   	ret    

0010337e <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  10337e:	55                   	push   %ebp
  10337f:	89 e5                	mov    %esp,%ebp
  103381:	57                   	push   %edi
  103382:	56                   	push   %esi
  103383:	53                   	push   %ebx
  103384:	83 ec 30             	sub    $0x30,%esp
  103387:	8b 45 08             	mov    0x8(%ebp),%eax
  10338a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  10338d:	8b 45 0c             	mov    0xc(%ebp),%eax
  103390:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103393:	8b 45 10             	mov    0x10(%ebp),%eax
  103396:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  103399:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10339c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  10339f:	73 42                	jae    1033e3 <memmove+0x65>
  1033a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1033a7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1033aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
  1033ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1033b0:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  1033b3:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1033b6:	c1 e8 02             	shr    $0x2,%eax
  1033b9:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  1033bb:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1033be:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1033c1:	89 d7                	mov    %edx,%edi
  1033c3:	89 c6                	mov    %eax,%esi
  1033c5:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  1033c7:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  1033ca:	83 e1 03             	and    $0x3,%ecx
  1033cd:	74 02                	je     1033d1 <memmove+0x53>
  1033cf:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  1033d1:	89 f0                	mov    %esi,%eax
  1033d3:	89 fa                	mov    %edi,%edx
  1033d5:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  1033d8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  1033db:	89 45 d0             	mov    %eax,-0x30(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  1033de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1033e1:	eb 36                	jmp    103419 <memmove+0x9b>
    asm volatile (
            "std;"
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  1033e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1033e6:	8d 50 ff             	lea    -0x1(%eax),%edx
  1033e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1033ec:	01 c2                	add    %eax,%edx
  1033ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1033f1:	8d 48 ff             	lea    -0x1(%eax),%ecx
  1033f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1033f7:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
        return __memcpy(dst, src, n);
    }
    int d0, d1, d2;
    asm volatile (
  1033fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1033fd:	89 c1                	mov    %eax,%ecx
  1033ff:	89 d8                	mov    %ebx,%eax
  103401:	89 d6                	mov    %edx,%esi
  103403:	89 c7                	mov    %eax,%edi
  103405:	fd                   	std    
  103406:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103408:	fc                   	cld    
  103409:	89 f8                	mov    %edi,%eax
  10340b:	89 f2                	mov    %esi,%edx
  10340d:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  103410:	89 55 c8             	mov    %edx,-0x38(%ebp)
  103413:	89 45 c4             	mov    %eax,-0x3c(%ebp)
            "rep; movsb;"
            "cld;"
            : "=&c" (d0), "=&S" (d1), "=&D" (d2)
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
            : "memory");
    return dst;
  103416:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  103419:	83 c4 30             	add    $0x30,%esp
  10341c:	5b                   	pop    %ebx
  10341d:	5e                   	pop    %esi
  10341e:	5f                   	pop    %edi
  10341f:	5d                   	pop    %ebp
  103420:	c3                   	ret    

00103421 <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  103421:	55                   	push   %ebp
  103422:	89 e5                	mov    %esp,%ebp
  103424:	57                   	push   %edi
  103425:	56                   	push   %esi
  103426:	83 ec 20             	sub    $0x20,%esp
  103429:	8b 45 08             	mov    0x8(%ebp),%eax
  10342c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  10342f:	8b 45 0c             	mov    0xc(%ebp),%eax
  103432:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103435:	8b 45 10             	mov    0x10(%ebp),%eax
  103438:	89 45 ec             	mov    %eax,-0x14(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  10343b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10343e:	c1 e8 02             	shr    $0x2,%eax
  103441:	89 c1                	mov    %eax,%ecx
#ifndef __HAVE_ARCH_MEMCPY
#define __HAVE_ARCH_MEMCPY
static inline void *
__memcpy(void *dst, const void *src, size_t n) {
    int d0, d1, d2;
    asm volatile (
  103443:	8b 55 f4             	mov    -0xc(%ebp),%edx
  103446:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103449:	89 d7                	mov    %edx,%edi
  10344b:	89 c6                	mov    %eax,%esi
  10344d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  10344f:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  103452:	83 e1 03             	and    $0x3,%ecx
  103455:	74 02                	je     103459 <memcpy+0x38>
  103457:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  103459:	89 f0                	mov    %esi,%eax
  10345b:	89 fa                	mov    %edi,%edx
  10345d:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  103460:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  103463:	89 45 e0             	mov    %eax,-0x20(%ebp)
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
            : "memory");
    return dst;
  103466:	8b 45 f4             	mov    -0xc(%ebp),%eax
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  103469:	83 c4 20             	add    $0x20,%esp
  10346c:	5e                   	pop    %esi
  10346d:	5f                   	pop    %edi
  10346e:	5d                   	pop    %ebp
  10346f:	c3                   	ret    

00103470 <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  103470:	55                   	push   %ebp
  103471:	89 e5                	mov    %esp,%ebp
  103473:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  103476:	8b 45 08             	mov    0x8(%ebp),%eax
  103479:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  10347c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10347f:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  103482:	eb 30                	jmp    1034b4 <memcmp+0x44>
        if (*s1 != *s2) {
  103484:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103487:	0f b6 10             	movzbl (%eax),%edx
  10348a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  10348d:	0f b6 00             	movzbl (%eax),%eax
  103490:	38 c2                	cmp    %al,%dl
  103492:	74 18                	je     1034ac <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  103494:	8b 45 fc             	mov    -0x4(%ebp),%eax
  103497:	0f b6 00             	movzbl (%eax),%eax
  10349a:	0f b6 d0             	movzbl %al,%edx
  10349d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1034a0:	0f b6 00             	movzbl (%eax),%eax
  1034a3:	0f b6 c0             	movzbl %al,%eax
  1034a6:	29 c2                	sub    %eax,%edx
  1034a8:	89 d0                	mov    %edx,%eax
  1034aa:	eb 1a                	jmp    1034c6 <memcmp+0x56>
        }
        s1 ++, s2 ++;
  1034ac:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1034b0:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
    const char *s1 = (const char *)v1;
    const char *s2 = (const char *)v2;
    while (n -- > 0) {
  1034b4:	8b 45 10             	mov    0x10(%ebp),%eax
  1034b7:	8d 50 ff             	lea    -0x1(%eax),%edx
  1034ba:	89 55 10             	mov    %edx,0x10(%ebp)
  1034bd:	85 c0                	test   %eax,%eax
  1034bf:	75 c3                	jne    103484 <memcmp+0x14>
        if (*s1 != *s2) {
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
        }
        s1 ++, s2 ++;
    }
    return 0;
  1034c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1034c6:	c9                   	leave  
  1034c7:	c3                   	ret    
