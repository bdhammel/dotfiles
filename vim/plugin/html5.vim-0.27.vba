" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
autoload/xml/aria.vim	[[[1
232
" Vim completion for WAI-ARIA data file
" Language:       HTML + WAI-ARIA
" Maintainer:     othree <othree@gmail.com>
" Last Change:    2010 Sep 09

" WAI_ARIA: {{{
" Ref: http://www.w3.org/TR/wai-aria/
" Version: Draft 15 December 2009

let abstract_role = {}
let role_attributes = {}
let default_role = {}

" Ref: http://www.w3.org/TR/wai-aria/roles
" Version: Draft 15 December 2009
let widget_role = ['alert', 'alertdialog', 'button', 'checkbox', 'combobox', 'dialog', 'gridcell', 'link', 'log', 'marquee', 'menuitem', 'menuitemcheckbox', 'menuitemradio', 'option', 'progressbar', 'radio', 'radiogroup', 'scrollbar', 'slider', 'spinbutton', 'status', 'tab', 'tabpanel', 'textbox', 'timer', 'tooltip', 'treeitem', 'combobox', 'grid', 'listbox', 'menu', 'menubar', 'radiogroup', 'tablist', 'tree', 'treegrid']
let document_structure = ['article', 'columnheader', 'definition', 'directory', 'document', 'group', 'heading', 'img', 'list', 'listitem', 'math', 'note', 'presentation', 'region', 'row', 'rowheader', 'separator']
let landmark_role = ['application', 'banner', 'complementary', 'contentinfo', 'form', 'main', 'navigation', 'search']
let role = extend(widget_role, document_structure)
let role = extend(role, landmark_role)

" http://www.w3.org/TR/wai-aria/states_and_properties#state_prop_taxonomy
"let global_states_and_properties = {'aria-atomic': ['true', 'false'], 'aria-busy': ['true', 'false'], 'aria-controls': [], 'aria-describedby': [], 'aria-disabled': ['true', 'false'], 'aria-dropeffect': ['copy', 'move', 'link', 'execute', 'popup', 'none'], 'aria-flowto': [], 'aria-grabbed': ['true', 'false', 'undefined'], 'aria-haspopup': ['true', 'false'], 'aria-hidden': ['true', 'false'], 'aria-invalid': ['grammar', 'spelling', 'true', 'false'], 'aria-label': [], 'aria-labelledby': [], 'aria-live': ['off', 'polite', 'assertive'], 'aria-owns': [], 'aria-relevant': ['additions', 'removals', 'text', 'all']}
let widget_attributes = {'aria-autocomplete': ['inline', 'list', 'both', 'none'], 'aria-checked': ['true', 'false', 'mixed', 'undefined'], 'aria-disabled': ['true', 'false'], 'aria-expanded': ['true', 'false', 'undefined'], 'aria-haspopup': ['true', 'false'], 'aria-hidden': ['true', 'false'], 'aria-invalid': ['grammar', 'spelling', 'true', 'false'], 'aria-label': [], 'aria-level': [], 'aria-multiline': ['true', 'false'], 'aria-multiselectable': ['true', 'false'], 'aria-orientation': ['horizontal', 'vertical'], 'aria-pressed': ['true', 'false', 'mixed', 'undefined'], 'aria-readonly': ['true', 'false'], 'aria-required': ['true', 'false'], 'aria-selected': ['true', 'false', 'undefined'], 'aria-sort': ['ascending', 'descending', 'none', 'other'], 'aria-valuemax': [], 'aria-valuemin': [], 'aria-valuenow': [], 'aria-valuetext': []}
let live_region_attributes = {'aria-atomic': ['true', 'false'], 'aria-busy': ['true', 'false'], 'aria-live': ['off', 'polite', 'assertive'], 'aria-relevant': ['additions', 'removals', 'text', 'all', 'additions text']}
let drag_and_drop_attributes = {'aria-dropeffect': ['copy', 'move', 'link', 'execute', 'popup', 'none'], 'aria-grabbed': ['true', 'false', 'undefined']}
let relationship_attributes = {'aria-activedescendant': [], 'aria-controls': [], 'aria-describedby': [], 'aria-flowto': [], 'aria-labelledby': [], 'aria-owns': [], 'aria-posinset': [], 'aria-setsize': []}
let aria_attributes = widget_attributes
let aria_attributes = extend(aria_attributes, live_region_attributes)
let aria_attributes = extend(aria_attributes, drag_and_drop_attributes)
let aria_attributes = extend(aria_attributes, relationship_attributes)

" Abstract Roles
let abstract_role['roletype'] = ['aria-atomic', 'aria-busy', 'aria-controls', 'aria-describedby', 'aria-disabled', 'aria-dropeffect', 'aria-flowto', 'aria-grabbed', 'aria-haspopup', 'aria-hidden', 'aria-invalid', 'aria-label', 'aria-labelledby', 'aria-live', 'aria-owns', 'aria-relevant']
let role_attributes['default'] = abstract_role['roletype']
let abstract_role['structure'] = abstract_role['roletype']
let abstract_role['widget'] = abstract_role['roletype']
let abstract_role['window'] = abstract_role['roletype'] + ['aria-expanded']
let abstract_role['composite'] = abstract_role['widget'] + ['aria-activedescendant']
let abstract_role['input'] = abstract_role['widget']
let abstract_role['section'] = abstract_role['structure'] + ['aria-expanded']
let abstract_role['sectionhead'] = abstract_role['structure'] + ['aria-expanded']

let role_attributes['group'] = abstract_role['section']
let abstract_role['select'] = abstract_role['composite'] + role_attributes['group'] + abstract_role['input']

let abstract_role['range'] = abstract_role['input'] + ['aria-valuemax', 'aria-valuemin', 'aria-valuenow', 'aria-valuetext']

let role_attributes['region'] = abstract_role['section']
let abstract_role['landmark'] = role_attributes['region']

" Widget Roles
let role_attributes['list'] = role_attributes['region'] 
let role_attributes['listitem'] = abstract_role['section']

let role_attributes['dialog'] = abstract_role['window']
let role_attributes['menuitem'] = abstract_role['input'] 
let role_attributes['checkbox'] = abstract_role['input'] + ['aria-checked'] 
let role_attributes['menuitemcheckbox'] = role_attributes['menuitem'] + role_attributes['checkbox']
let role_attributes['option'] = abstract_role['input'] + ['aria-checked', 'aria-posinset', 'aria-selected', 'aria-setsize']
let role_attributes['radio'] = role_attributes['checkbox'] + role_attributes['option']

let role_attributes['directory'] = role_attributes['list'] 

let role_attributes['alert'] = role_attributes['region']
let role_attributes['alertdialog'] = role_attributes['alert'] + role_attributes['dialog']
let role_attributes['button'] = role_attributes['region'] + role_attributes['menuitemcheckbox']
let role_attributes['combobox'] = abstract_role['select'] + ['aria-expanded', 'aria-required'] 
let role_attributes['gridcell'] = abstract_role['section'] + abstract_role['widget']
let role_attributes['link'] = abstract_role['widget'] 
let role_attributes['log'] = role_attributes['region'] 
let role_attributes['marquee'] = role_attributes['region'] 
let role_attributes['menuitemradio'] = role_attributes['menuitemcheckbox'] + role_attributes['radio']
let role_attributes['progressbar'] = abstract_role['widget'] + ['aria-valuemax', 'aria-valuemin', 'aria-valuenow', 'aria-valuetext']
let role_attributes['radiogroup'] = abstract_role['select'] + ['aria-required']
let role_attributes['scrollbar'] = abstract_role['range'] + ['aria-controls', 'aria-orientation', 'aria-valuemax', 'aria-valuemin', 'aria-valuenow']
let role_attributes['slider'] = abstract_role['range'] + ['aria-valuemax', 'aria-valuemin', 'aria-valuenow']
let role_attributes['spinbutton'] = abstract_role['composite'] + abstract_role['range'] + ['aria-required'] 
let role_attributes['status'] = abstract_role['composite'] + role_attributes['region']
let role_attributes['tab'] = abstract_role['sectionhead'] + abstract_role['widget'] + ['aria-selected']
let role_attributes['tabpanel'] = role_attributes['region']
let role_attributes['textbox'] = abstract_role['input'] + ['aria-autocomplete', 'aria-multiline', 'aria-readonly', 'aria-required']
let role_attributes['timer'] = role_attributes['status'] 
let role_attributes['tooltip'] = abstract_role['section'] 
let role_attributes['treeitem'] = role_attributes['listitem'] + role_attributes['option']

let role_attributes['grid'] = abstract_role['composite'] + role_attributes['region'] + ['aria-level', 'aria-multiselectable', 'aria-readonly']
let role_attributes['listbox'] = role_attributes['list'] + abstract_role['select'] + ['aria-multiselectable', 'aria-required']
let role_attributes['menu'] =  role_attributes['list'] + abstract_role['select'] 
let role_attributes['menubar'] = role_attributes['menu'] 
let role_attributes['tablist'] = abstract_role['composite'] + role_attributes['directory']
let role_attributes['toolbar'] = role_attributes['group'] 
let role_attributes['tree'] = abstract_role['select'] + ['aria-multiselectable', 'aria-required']
let role_attributes['treegrid'] = role_attributes['grid'] + role_attributes['tree']

" Document Structure
let role_attributes['document'] = abstract_role['structure'] + ['aria-expanded'] 

let role_attributes['article'] = role_attributes['document'] + role_attributes['region'] 
let role_attributes['columnheader'] = role_attributes['gridcell'] + abstract_role['sectionhead'] + ['aria-sort']
let role_attributes['definition'] = abstract_role['section'] 
let role_attributes['heading'] = abstract_role['sectionhead'] + ['aria-level'] 
let role_attributes['img'] = abstract_role['section'] 
let role_attributes['math'] = abstract_role['section'] 
let role_attributes['note'] = abstract_role['section'] 
let role_attributes['presentation'] = abstract_role['structure']
let role_attributes['row'] = role_attributes['group'] + ['aria-level', 'aria-selected']
let role_attributes['rowheader'] = role_attributes['gridcell'] + abstract_role['sectionhead']
let role_attributes['separator'] = abstract_role['structure'] + ['aria-expanded'] 

" Landmark Roles
let role_attributes['application'] = abstract_role['landmark'] 
let role_attributes['banner'] = abstract_role['landmark'] 
let role_attributes['complementary'] = abstract_role['landmark'] 
let role_attributes['contentinfo'] = abstract_role['landmark'] 
let role_attributes['form'] = abstract_role['landmark'] 
let role_attributes['main'] = abstract_role['landmark'] 
let role_attributes['navigation'] = abstract_role['landmark'] 
let role_attributes['search'] = abstract_role['landmark']

" http://www.w3.org/TR/wai-aria/states_and_properties#state_prop_def
let aria_attributes_value = {
    \ 'aria-autocomplete': ['ID', ''],
    \ 'aria-checked': ['Token', ''],
    \ 'aria-disabled': ['true/false', ''],
    \ 'aria-expanded': ['Token', ''],
    \ 'aria-haspopup': ['true/false', ''],
    \ 'aria-hidden': ['true/false', ''],
    \ 'aria-invalid': ['Token', ''],
    \ 'aria-label': ['String', ''],
    \ 'aria-level': ['Int', ''],
    \ 'aria-multiline': ['true/false', ''],
    \ 'aria-multiselectable': ['true/false', ''],
    \ 'aria-orientation': ['Token', ''],
    \ 'aria-pressed': ['Token', ''],
    \ 'aria-readonly': ['true/false', ''],
    \ 'aria-required': ['true/false', ''],
    \ 'aria-selected': ['Token', ''],
    \ 'aria-sort': ['Token', ''],
    \ 'aria-valuemax': ['Number', ''],
    \ 'aria-valuemin': ['Number', ''],
    \ 'aria-valuenow': ['Number', ''],
    \ 'aria-valuetext': ['String', ''],
    \ 'aria-atomic': ['true/false', ''],
    \ 'aria-busy': ['true/false', ''],
    \ 'aria-live': ['Token', ''],
    \ 'aria-relevant': ['*Token', ''],
    \ 'aria-dropeffect': ['*Token', ''],
    \ 'aria-grabbed': ['Token', ''],
    \ 'aria-activedescendant': ['ID', ''],
    \ 'aria-controls': ['*ID', ''],
    \ 'aria-describedby': ['*ID', ''],
    \ 'aria-flowto': ['*ID', ''],
    \ 'aria-labelledby': ['*ID', ''],
    \ 'aria-owns': ['*ID', ''],
    \ 'aria-posinset': ['Int', ''],
    \ 'aria-setsize': ['Int', '']
\ }

" http://dev.w3.org/html5/spec/content-models.html#annotations-for-assistive-technology-products-aria
let default_role = {
    \ 'a': 'link',
    \ 'area': 'link',
    \ 'body': 'document',
    \ 'button': 'button',
    \ 'datalist': 'listbox',
    \ 'h1': 'heading',
    \ 'h2': 'heading',
    \ 'h3': 'heading',
    \ 'h4': 'heading',
    \ 'h5': 'heading',
    \ 'h6': 'heading',
    \ 'hgroup': 'heading',
    \ 'hr': 'separator',
    \ 'img[alt=]': 'presentation',
    \ 'input[type=button]': 'button',
    \ 'input[type=email]': 'textbox',
    \ 'input[type=image]': 'button',
    \ 'input[type=number]': 'spinbutton',
    \ 'input[type=password]': 'textbox',
    \ 'input[type=range]': 'slider',
    \ 'input[type=reset]': 'button',
    \ 'input[type=search]': 'textbox',
    \ 'input[type=submit]': 'button',
    \ 'input[type=tel]': 'textbox',
    \ 'input[type=text]': 'textbox',
    \ 'input[list]': 'combobox',
    \ 'input[type=url]': 'textbox',
    \ 'input': 'textbox',
    \ 'keygen': 'default',
    \ 'label': 'default',
    \ 'menu[type=list]': 'menu',
    \ 'menu[type=toolbar]': 'toolbar',
    \ 'menu': 'default',
    \ 'link': 'link',
    \ 'nav': 'navigation',
    \ 'optgroup': 'default',
    \ 'option': 'option',
    \ 'progress': 'progressbar',
    \ 'select': 'listbox',
    \ 'summary': 'heading',
    \ 'tbody': 'rowgroup',
    \ 'td': 'gridcell',
    \ 'textarea': 'textbox',
    \ 'tfoot': 'rowgroup',
    \ 'th[scope=col]': 'columnheader',
    \ 'th[scope=row]': 'rowheader',
    \ 'tr': 'row',
    \ 'address': 'default',
    \ 'article': 'article',
    \ 'aside': 'note',
    \ 'footer': 'default',
    \ 'header': 'default',
    \ 'details': 'group',
    \ 'img': 'img',
    \ 'input[type=checkbox]': 'checkbox',
    \ 'input[type=radio]': 'radio',
    \ 'li': 'listitem',
    \ 'ol': 'list',
    \ 'output': 'status',
    \ 'section': 'region',
    \ 'table': 'grid',
    \ 'ul': 'list',
\ }
" }}}

let g:xmldata_aria = {
    \ 'aria_attributes': aria_attributes,
    \ 'role_attributes': role_attributes,
    \ 'default_role': default_role,
    \ 'vimariaattrinfo': aria_attributes_value
\ }
autoload/xml/html5.vim	[[[1
791
" Vim completion for HTML5 data file
" Language:       HTML5
" Maintainer:     othree <othree@gmail.com>
" Last Change:    2011 Apr 9


" Lang Tag: {{{
" Ref: http://www.iana.org/assignments/language-subtag-registry
" Version: 2010/09/07
" Description: only get two-letter language tag
let lang_tag = [
    \ 'aa', 'ab', 'ae', 'af', 'ak', 'am', 'an', 'ar', 'as', 'av', 'ay', 'az', 'ba', 'be', 'bg', 'bh', 'bi', 'bm',
    \ 'bn', 'bo', 'br', 'bs', 'ca', 'ce', 'ch', 'co', 'cr', 'cs', 'cu', 'cv', 'cy', 'da', 'de', 'dv', 'dz', 'ee',
    \ 'el', 'en', 'eo', 'es', 'et', 'eu', 'fa', 'ff', 'fi', 'fj', 'fo', 'fr', 'fy', 'ga', 'gd', 'gl', 'gn', 'gu',
    \ 'gv', 'ha', 'he', 'hi', 'ho', 'hr', 'ht', 'hu', 'hy', 'hz', 'ia', 'id', 'ie', 'ig', 'ii', 'ik', 'in', 'io',
    \ 'is', 'it', 'iu', 'iw', 'ja', 'ji', 'jv', 'jw', 'ka', 'kg', 'ki', 'kj', 'kk', 'kl', 'km', 'kn', 'ko', 'kr',
    \ 'ks', 'ku', 'kv', 'kw', 'ky', 'la', 'lb', 'lg', 'li', 'ln', 'lo', 'lt', 'lu', 'lv', 'mg', 'mh', 'mi', 'mk',
    \ 'ml', 'mn', 'mo', 'mr', 'ms', 'mt', 'my', 'na', 'nb', 'nd', 'ne', 'ng', 'nl', 'nn', 'no', 'nr', 'nv', 'ny',
    \ 'oc', 'oj', 'om', 'or', 'os', 'pa', 'pi', 'pl', 'ps', 'pt', 'qu', 'rm', 'rn', 'ro', 'ru', 'rw', 'sa', 'sc',
    \ 'sd', 'se', 'sg', 'sh', 'si', 'sk', 'sl', 'sm', 'sn', 'so', 'sq', 'sr', 'ss', 'st', 'su', 'sv', 'sw', 'ta',
    \ 'te', 'tg', 'th', 'ti', 'tk', 'tl', 'tn', 'to', 'tr', 'ts', 'tt', 'tw', 'ty', 'ug', 'uk', 'ur', 'uz', 've',
    \ 'vi', 'vo', 'wa', 'wo', 'xh', 'yi', 'yo', 'za', 'zh', 'zu', 'zh-CN', 'zh-TW']
" }}}

" Charset: {{{
" Ref: http://www.iana.org/assignments/character-sets 
" Version: 2010/09/07
let charset = [
    \ 'ANSI_X3.4-1968', 'ISO_8859-1:1987', 'ISO_8859-2:1987', 'ISO_8859-3:1988', 'ISO_8859-4:1988', 'ISO_8859-5:1988', 
    \ 'ISO_8859-6:1987', 'ISO_8859-7:1987', 'ISO_8859-8:1988', 'ISO_8859-9:1989', 'ISO-8859-10', 'ISO_6937-2-add', 'JIS_X0201', 
    \ 'JIS_Encoding', 'Shift_JIS', 'Extended_UNIX_Code_Packed_Format_for_Japanese', 'Extended_UNIX_Code_Fixed_Width_for_Japanese',
    \ 'BS_4730', 'SEN_850200_C', 'IT', 'ES', 'DIN_66003', 'NS_4551-1', 'NF_Z_62-010', 'ISO-10646-UTF-1', 'ISO_646.basic:1983', 
    \ 'INVARIANT', 'ISO_646.irv:1983', 'NATS-SEFI', 'NATS-SEFI-ADD', 'NATS-DANO', 'NATS-DANO-ADD', 'SEN_850200_B', 'KS_C_5601-1987',
    \ 'ISO-2022-KR', 'EUC-KR', 'ISO-2022-JP', 'ISO-2022-JP-2', 'JIS_C6220-1969-jp', 'JIS_C6220-1969-ro', 'PT', 'greek7-old', 
    \ 'latin-greek', 'NF_Z_62-010_(1973)', 'Latin-greek-1', 'ISO_5427', 'JIS_C6226-1978', 'BS_viewdata', 'INIS', 'INIS-8', 
    \ 'INIS-cyrillic', 'ISO_5427:1981', 'ISO_5428:1980', 'GB_1988-80', 'GB_2312-80', 'NS_4551-2', 'videotex-suppl', 'PT2', 
    \ 'ES2', 'MSZ_7795.3', 'JIS_C6226-1983', 'greek7', 'ASMO_449', 'iso-ir-90', 'JIS_C6229-1984-a', 'JIS_C6229-1984-b', 
    \ 'JIS_C6229-1984-b-add', 'JIS_C6229-1984-hand', 'JIS_C6229-1984-hand-add', 'JIS_C6229-1984-kana', 'ISO_2033-1983', 
    \ 'ANSI_X3.110-1983', 'T.61-7bit', 'T.61-8bit', 'ECMA-cyrillic', 'CSA_Z243.4-1985-1', 'CSA_Z243.4-1985-2', 'CSA_Z243.4-1985-gr', 
    \ 'ISO_8859-6-E', 'ISO_8859-6-I', 'T.101-G2', 'ISO_8859-8-E', 'ISO_8859-8-I', 'CSN_369103', 'JUS_I.B1.002', 'IEC_P27-1', 
    \ 'JUS_I.B1.003-serb', 'JUS_I.B1.003-mac', 'greek-ccitt', 'NC_NC00-10:81', 'ISO_6937-2-25', 'GOST_19768-74', 'ISO_8859-supp', 
    \ 'ISO_10367-box', 'latin-lap', 'JIS_X0212-1990', 'DS_2089', 'us-dk', 'dk-us', 'KSC5636', 'UNICODE-1-1-UTF-7', 'ISO-2022-CN', 
    \ 'ISO-2022-CN-EXT', 'UTF-8', 'ISO-8859-13', 'ISO-8859-14', 'ISO-8859-15', 'ISO-8859-16', 'GBK', 'GB18030', 'OSD_EBCDIC_DF04_15', 
    \ 'OSD_EBCDIC_DF03_IRV', 'OSD_EBCDIC_DF04_1', 'ISO-11548-1', 'KZ-1048', 'ISO-10646-UCS-2', 'ISO-10646-UCS-4', 'ISO-10646-UCS-Basic',
    \ 'ISO-10646-Unicode-Latin1', 'ISO-10646-J-1', 'ISO-Unicode-IBM-1261', 'ISO-Unicode-IBM-1268', 'ISO-Unicode-IBM-1276', 
    \ 'ISO-Unicode-IBM-1264', 'ISO-Unicode-IBM-1265', 'UNICODE-1-1', 'SCSU', 'UTF-7', 'UTF-16BE', 'UTF-16LE', 'UTF-16', 'CESU-8', 
    \ 'UTF-32', 'UTF-32BE', 'UTF-32LE', 'BOCU-1', 'ISO-8859-1-Windows-3.0-Latin-1', 'ISO-8859-1-Windows-3.1-Latin-1', 
    \ 'ISO-8859-2-Windows-Latin-2', 'ISO-8859-9-Windows-Latin-5', 'hp-roman8', 'Adobe-Standard-Encoding', 'Ventura-US', 
    \ 'Ventura-International', 'DEC-MCS', 'IBM850', 'PC8-Danish-Norwegian', 'IBM862', 'PC8-Turkish', 'IBM-Symbols', 'IBM-Thai', 
    \ 'HP-Legal', 'HP-Pi-font', 'HP-Math8', 'Adobe-Symbol-Encoding', 'HP-DeskTop', 'Ventura-Math', 'Microsoft-Publishing', 
    \ 'Windows-31J', 'GB2312', 'Big5', 'macintosh', 'IBM037', 'IBM038', 'IBM273', 'IBM274', 'IBM275', 'IBM277', 'IBM278', 
    \ 'IBM280', 'IBM281', 'IBM284', 'IBM285', 'IBM290', 'IBM297', 'IBM420', 'IBM423', 'IBM424', 'IBM437', 'IBM500', 'IBM851', 
    \ 'IBM852', 'IBM855', 'IBM857', 'IBM860', 'IBM861', 'IBM863', 'IBM864', 'IBM865', 'IBM868', 'IBM869', 'IBM870', 'IBM871', 
    \ 'IBM880', 'IBM891', 'IBM903', 'IBM904', 'IBM905', 'IBM918', 'IBM1026', 'EBCDIC-AT-DE', 'EBCDIC-AT-DE-A', 'EBCDIC-CA-FR', 
    \ 'EBCDIC-DK-NO', 'EBCDIC-DK-NO-A', 'EBCDIC-FI-SE', 'EBCDIC-FI-SE-A', 'EBCDIC-FR', 'EBCDIC-IT', 'EBCDIC-PT', 'EBCDIC-ES', 
    \ 'EBCDIC-ES-A', 'EBCDIC-ES-S', 'EBCDIC-UK', 'EBCDIC-US', 'UNKNOWN-8BIT', 'MNEMONIC', 'MNEM', 'VISCII', 'VIQR', 'KOI8-R', 
    \ 'HZ-GB-2312', 'IBM866', 'IBM775', 'KOI8-U', 'IBM00858', 'IBM00924', 'IBM01140', 'IBM01141', 'IBM01142', 'IBM01143', 
    \ 'IBM01144', 'IBM01145', 'IBM01146', 'IBM01147', 'IBM01148', 'IBM01149', 'Big5-HKSCS', 'IBM1047', 'PTCP154', 'Amiga-1251', 
    \ 'KOI7-switched', 'BRF', 'TSCII', 'windows-1250', 'windows-1251', 'windows-1252', 'windows-1253', 'windows-1254', 'windows-1255', 
    \ 'windows-1256', 'windows-1257', 'windows-1258', 'TIS-620', ]
" }}}

" Attributes_and_Settings: {{{
let core_attributes = {'accesskey': [], 'class': [], 'contenteditable': ['true', 'false', ''], 'contextmenu': [], 'dir': ['ltr', 'rtl'], 'draggable': ['true', 'false'], 'hidden': ['hidden', ''], 'id': [], 'lang': lang_tag, 'spellcheck': ['true', 'false', ''], 'style': [], 'tabindex': [], 'title': []}
let xml_attributes = {'xml:lang': lang_tag, 'xml:space': ['preserve'], 'xml:base': [], 'xmlns': []}

let body_attributes = {}
let global_attributes = extend(core_attributes, xml_attributes)
if !exists('g:event_handler_attributes_complete')
    let g:event_handler_attributes_complete = 1
endif

" http://dev.w3.org/html5/spec/Overview.html#attributes-1
let attributes_value = {
    \ 'accept': ['MIME', ''],
    \ 'accept-charset': ['Charset', ''],
    \ 'accesskey': ['Character', ''],
    \ 'action': ['URL', ''],
    \ 'alt': ['Text', ''],
    \ 'async': ['Bool', ''],
    \ 'autocomplete': ['on/off', ''],
    \ 'autofocus': ['Bool', ''],
    \ 'autoplay': ['Bool', ''],
    \ 'border': ['1', ''],
    \ 'challenge': ['Text', ''],
    \ 'charset': ['Charset', ''],
    \ 'checked': ['Bool', ''],
    \ 'cite': ['URL', ''],
    \ 'class': ['*Token', ''],
    \ 'cols': ['Int', ''],
    \ 'colspan': ['Int', ''],
    \ 'content': ['Text', ''],
    \ 'contenteditable': ['true/false', ''],
    \ 'contextmenu': ['ID', ''],
    \ 'controls': ['Bool', ''],
    \ 'coords': ['*Int', ''],
    \ 'data': ['URL', ''],
    \ 'datetime': ['Datetime', ''],
    \ 'defer': ['Bool', ''],
    \ 'dir': ['ltr/rtl', ''],
    \ 'disabled': ['Bool', ''],
    \ 'draggable': ['true/false', ''],
    \ 'enctype': ['Token', ''],
    \ 'for': ['ID', ''],
    \ 'form': ['ID', ''],
    \ 'formaction': ['URL', ''],
    \ 'formenctype': ['Token', ''],
    \ 'formmethod': ['HTTP Method', ''],
    \ 'formnovalidate': ['Bool', ''],
    \ 'formtarget': ['Name', ''],
    \ 'headers': ['*ID', ''],
    \ 'height': ['Int', ''],
    \ 'hidden': ['Bool', ''],
    \ 'high': ['Number', ''],
    \ 'href': ['URL', ''],
    \ 'hreflang': ['Lang Tag', ''],
    \ 'http-equiv': ['Text', ''],
    \ 'icon': ['URL', ''],
    \ 'id': ['Text', ''],
    \ 'ismap': ['Bool', ''],
    \ 'keytype': ['Text', ''],
    \ 'label': ['Text', ''],
    \ 'lang': ['Lang Tag', ''],
    \ 'list': ['ID', ''],
    \ 'loop': ['Bool', ''],
    \ 'low': ['Number', ''],
    \ 'manifest': ['URL', ''],
    \ 'max': ['Number', ''],
    \ 'maxlength': ['Int', ''],
    \ 'media': ['Text', ''],
    \ 'method': ['HTTP Method', ''],
    \ 'min': ['Number', ''],
    \ 'multiple': ['Bool', ''],
    \ 'name': ['Text', ''],
    \ 'novalidate': ['Bool', ''],
    \ 'open': ['Bool', ''],
    \ 'optimum': ['Number', ''],
    \ 'pattern': ['Pattern', ''],
    \ 'placeholder': ['Text', ''],
    \ 'poster': ['URL', ''],
    \ 'preload': ['Token', ''],
    \ 'pubdate': ['Bool', ''],
    \ 'radiogroup': ['Text', ''],
    \ 'readonly': ['Bool', ''],
    \ 'rel': ['*Token', ''],
    \ 'required': ['Bool', ''],
    \ 'reversed': ['Bool', ''],
    \ 'rows': ['Int', ''],
    \ 'rowspan': ['Int', ''],
    \ 'sandbox': ['*Token', ''],
    \ 'spellcheck': ['true/false', ''],
    \ 'scope': ['Token', ''],
    \ 'scoped': ['Bool', ''],
    \ 'seamless': ['Bool', ''],
    \ 'selected': ['Bool', ''],
    \ 'shape': ['Token', ''],
    \ 'size': ['Int', ''],
    \ 'sizes': ['*Token', ''],
    \ 'span': ['Int', ''],
    \ 'src': ['Int', ''],
    \ 'srcdoc': ['Document', ''],
    \ 'start': ['Int', ''],
    \ 'step': ['Int', ''],
    \ 'style': ['Style', ''],
    \ 'summary': ['Text', ''],
    \ 'tabindex': ['Int', ''],
    \ 'target': ['Name', ''],
    \ 'title': ['Text', ''],
    \ 'type': ['Token', ''],
    \ 'usemap': ['Name', ''],
    \ 'value': ['Text', ''],
    \ 'width': ['Int', ''],
    \ 'wrap': ['soft/hard', ''],
    \ 'xml:lang': ['Lang tag', ''],
    \ 'xml:base': ['*URI', ''],
    \ 'xml:space': ['preserve', ''],
    \ 'xmlns': ['URI', ''],
    \ 'version': ['HTML+RDFa 1.1', ''],
    \ 'role': ['*Token', '']
\ }

if g:event_handler_attributes_complete == 1
    let event_handler_attributes = {'onabort': [], 'onblur': [], 'oncanplay': [], 'oncanplaythrough': [], 'onchange': [], 'onclick': [], 'oncontextmenu': [], 'ondblclick': [], 'ondrag': [], 'ondragend': [], 'ondragenter': [], 'ondragleave': [], 'ondragover': [], 'ondragstart': [], 'ondrop': [], 'ondurationchange': [], 'onemptied': [], 'onended': [], 'onerror': [], 'onfocus': [], 'onformchange': [], 'onforminput': [], 'oninput': [], 'oninvalid': [], 'onkeydown': [], 'onkeypress': [], 'onkeyup': [], 'onload': [], 'onloadeddata': [], 'onloadedmetadata': [], 'onloadstart': [], 'onmousedown': [], 'onmousemove': [], 'onmouseout': [], 'onmouseover': [], 'onmouseup': [], 'onmousewheel': [], 'onpause': [], 'onplay': [], 'onplaying': [], 'onprogress': [], 'onratechange': [], 'onreadystatechange': [], 'onscroll': [], 'onseeked': [], 'onseeking': [], 'onselect': [], 'onshow': [], 'onstalled': [], 'onsubmit': [], 'onsuspend': [], 'ontimeupdate': [], 'onvolumechange': [], 'onwaiting': []}
    let global_attributes = extend(global_attributes, event_handler_attributes)
    
    let body_attributes = {'onafterprint': [], 'onbeforeprint': [], 'onbeforeunload': [], 'onblur': [], 'onerror': [], 'onfocus': [], 'onhashchange': [], 'onload': [], 'onmessage': [], 'onoffline': [], 'ononline': [], 'onpopstate': [], 'onredo': [], 'onresize': [], 'onstorage': [], 'onundo': [], 'onunload': []}

    let event_attributes_value = {
        \ 'onabort': ['Script', ''],
        \ 'onafterprint': ['Script', ''],
        \ 'onbeforeprint': ['Script', ''],
        \ 'onbeforeunload': ['Script', ''],
        \ 'onblur': ['Script', ''],
        \ 'oncanplay': ['Script', ''],
        \ 'oncanplaythrough': ['Script', ''],
        \ 'onchange': ['Script', ''],
        \ 'onclick': ['Script', ''],
        \ 'oncontextmenu': ['Script', ''],
        \ 'ondblclick': ['Script', ''],
        \ 'ondrag': ['Script', ''],
        \ 'ondragend': ['Script', ''],
        \ 'ondragenter': ['Script', ''],
        \ 'ondragleave': ['Script', ''],
        \ 'ondragover': ['Script', ''],
        \ 'ondragstart': ['Script', ''],
        \ 'ondrop': ['Script', ''],
        \ 'ondurationchange': ['Script', ''],
        \ 'onemptied': ['Script', ''],
        \ 'onended': ['Script', ''],
        \ 'onerror': ['Script', ''],
        \ 'onfocus': ['Script', ''],
        \ 'onformchange': ['Script', ''],
        \ 'onforminput': ['Script', ''],
        \ 'onhashchange': ['Script', ''],
        \ 'oninput': ['Script', ''],
        \ 'oninvalid': ['Script', ''],
        \ 'onkeydown': ['Script', ''],
        \ 'onkeypress': ['Script', ''],
        \ 'onkeyup': ['Script', ''],
        \ 'onload': ['Script', ''],
        \ 'onloadeddata': ['Script', ''],
        \ 'onloadedmetadata': ['Script', ''],
        \ 'onloadstart': ['Script', ''],
        \ 'onmessage': ['Script', ''],
        \ 'onmousedown': ['Script', ''],
        \ 'onmousemove': ['Script', ''],
        \ 'onmouseout': ['Script', ''],
        \ 'onmouseover': ['Script', ''],
        \ 'onmouseup': ['Script', ''],
        \ 'onmousewheel': ['Script', ''],
        \ 'onoffline': ['Script', ''],
        \ 'ononline': ['Script', ''],
        \ 'onpagehide': ['Script', ''],
        \ 'onpageshow': ['Script', ''],
        \ 'onpause': ['Script', ''],
        \ 'onplay': ['Script', ''],
        \ 'onplaying': ['Script', ''],
        \ 'onpopstate': ['Script', ''],
        \ 'onprogress': ['Script', ''],
        \ 'onratechange': ['Script', ''],
        \ 'onreadystatechange': ['Script', ''],
        \ 'onredo': ['Script', ''],
        \ 'onresize': ['Script', ''],
        \ 'onscroll': ['Script', ''],
        \ 'onseeked': ['Script', ''],
        \ 'onseeking': ['Script', ''],
        \ 'onselect': ['Script', ''],
        \ 'onshow': ['Script', ''],
        \ 'onstalled': ['Script', ''],
        \ 'onstorage': ['Script', ''],
        \ 'onsubmit': ['Script', ''],
        \ 'onsuspend': ['Script', ''],
        \ 'ontimeupdate': ['Script', ''],
        \ 'onundo': ['Script', ''],
        \ 'onunload': ['Script', ''],
        \ 'onvolumechange': ['Script', ''],
        \ 'onwaiting': ['Script', '']
    \ }

    let attributes_value = extend(attributes_value, event_attributes_value)
endif
if !exists('g:rdfa_attributes_complete')
    let g:rdfa_attributes_complete = 1
endif
if g:rdfa_attributes_complete == 1
    " http://www.w3.org/TR/rdfa-syntax/#s_metaAttributes
    " http://www.w3.org/TR/rdfa-core/#s_syntax
    let relrev = ['chapter', 'contents', 'copyright', 'first', 'glossary', 'help', 'icon', 'index', 'last', 'license', 'meta', 'next', 'p3pv1', 'prev', 'role', 'section', 'stylesheet', 'subsection', 'start', 'top', 'up']
    let rdfa_attributes = {'about': [], 'content': [], 'datatype': [], 'prefix': [], 'profile': [], 'property': [], 'resource': [], 'rel': relrev, 'rev': relrev, 'typeof': [], 'vocab': []}
    let global_attributes = extend(global_attributes, rdfa_attributes)

    let rdfa_attributes_value = {
        \ 'about': ['SafeCURIEorCURIEorURI', ''],
        \ 'content': ['CDATA String', ''],
        \ 'datatype': ['CURIE', ''],
        \ 'prefix': ['*Prefix', ''],
        \ 'profile': ['String', ''],
        \ 'property': ['*TERMorCURIEorAbsURIs', ''],
        \ 'resource': ['URIorSafeCURIE', ''],
        \ 'rel': ['*TERMorCURIEorAbsURIs', ''],
        \ 'rev': ['*TERMorCURIEorAbsURIs', ''],
        \ 'typeof': ['*TERMorCURIEorAbsURIs', ''],
        \ 'vocab': ['URI', '']
    \ }
    let attributes_value = extend(attributes_value, rdfa_attributes_value)
endif
if !exists('g:microdata_attributes_complete')
    let g:microdata_attributes_complete = 1
endif
if g:microdata_attributes_complete == 1
    let microdata_attributes = {'itemid': [], 'itemscope': ['itemscope', ''], 'itemtype': [], 'itemprop': [], 'itemref': []}
    let global_attributes = extend(global_attributes, microdata_attributes)

    let microdata_attributes_value = {
        \ 'itemid': ['URI', ''],
        \ 'itemscope': ['Bool', ''],
        \ 'itemtype': ['URI', ''],
        \ 'itemprop': ['String', ''],
        \ 'itemref': ['*ID', '']
    \ }
    let attributes_value = extend(attributes_value, microdata_attributes_value)
endif
" }}}

" WAI_ARIA: {{{
" Ref: http://www.w3.org/TR/wai-aria/
" Version: Draft 15 December 2009
if !exists('g:aria_attributes_complete')
    let g:aria_attributes_complete = 1
endif
if g:aria_attributes_complete == 1
    " Ref: http://www.w3.org/TR/wai-aria/roles
    " Version: Draft 15 December 2009
    let widget_role = ['alert', 'alertdialog', 'button', 'checkbox', 'combobox', 'dialog', 'gridcell', 'link', 'log', 'marquee', 'menuitem', 'menuitemcheckbox', 'menuitemradio', 'option', 'progressbar', 'radio', 'radiogroup', 'scrollbar', 'slider', 'spinbutton', 'status', 'tab', 'tabpanel', 'textbox', 'timer', 'tooltip', 'treeitem', 'combobox', 'grid', 'listbox', 'menu', 'menubar', 'radiogroup', 'tablist', 'tree', 'treegrid']
    let document_structure = ['article', 'columnheader', 'definition', 'directory', 'document', 'group', 'heading', 'img', 'list', 'listitem', 'math', 'note', 'presentation', 'region', 'row', 'rowheader', 'separator']
    let landmark_role = ['application', 'banner', 'complementary', 'contentinfo', 'form', 'main', 'navigation', 'search']
    let role = extend(widget_role, document_structure)
    let role = extend(role, landmark_role)
    let global_attributes = extend(global_attributes, {'role': role})
endif
" }}}

" Ref: http://dev.w3.org/html5/markup/
" Version: Draft 05 April 2011
let phrasing_elements = ['a', 'em', 'strong', 'small', 'mark', 'abbr', 'dfn', 'i', 'b', 'u', 'code', 'var', 'samp', 'kbd', 'sup', 'sub', 'q', 'cite', 'span', 'bdo', 'bdi', 'br', 'wbr', 'ins', 'del', 'img', 'embed', 'object', 'iframe', 'map', 'area', 'script', 'noscript', 'ruby', 'video', 'audio', 'input', 'textarea', 'select', 'button', 'label', 'output', 'datalist', 'keygen', 'progress', 'command', 'canvas', 'time', 'meter']

let metadata_elements = ['link', 'style', 'meta', 'script', 'noscript', 'command']

let flow_elements = phrasing_elements + ['p', 'hr', 'pre', 'ul', 'ol', 'dl', 'div', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'hgroup', 'address', 'blockquote', 'ins', 'del', 'object', 'map', 'noscript', 'section', 'nav', 'article', 'aside', 'header', 'footer', 'video', 'audio', 'figure', 'table', 'form', 'fieldset', 'menu', 'canvas', 'details']

" http://dev.w3.org/html5/spec/Overview.html#linkTypes
let linktypes = ['alternate', 'author', 'bookmark', 'external', 'help', 'icon', 'license', 'next', 'nofollow', 'noreferrer', 'pingback', 'prefetch', 'prev', 'search', 'stylesheet', 'sidebar', 'tag']
" http://googlewebmastercentral.blogspot.com/2009/02/specify-your-canonical.html
let linkreltypes = linktypes + ['canonical']

" a and button are special elements for interactive, some element can't be its descendent
let abutton_dec = 'details\\|embed\\|iframe\\|keygen\\|label\\|menu\\|select\\|textarea'



let g:xmldata_html5 = {
\ 'vimxmlentities': ['AElig', 'Aacute', 'Acirc', 'Agrave', 'Alpha', 'Aring', 'Atilde', 'Auml', 'Beta', 'Ccedil', 'Chi', 'Dagger', 'Delta', 'ETH', 'Eacute', 'Ecirc', 'Egrave', 'Epsilon', 'Eta', 'Euml', 'Gamma', 'Iacute', 'Icirc', 'Igrave', 'Iota', 'Iuml', 'Kappa', 'Lambda', 'Mu', 'Ntilde', 'Nu', 'OElig', 'Oacute', 'Ocirc', 'Ograve', 'Omega', 'Omicron', 'Oslash', 'Otilde', 'Ouml', 'Phi', 'Pi', 'Prime', 'Psi', 'Rho', 'Scaron', 'Sigma', 'THORN', 'Tau', 'Theta', 'Uacute', 'Ucirc', 'Ugrave', 'Upsilon', 'Uuml', 'Xi', 'Yacute', 'Yuml', 'Zeta', 'aacute', 'acirc', 'acute', 'aelig', 'agrave', 'alefsym', 'alpha', 'amp', 'and', 'ang', 'apos', 'aring', 'asymp', 'atilde', 'auml', 'bdquo', 'beta', 'brvbar', 'bull', 'cap', 'ccedil', 'cedil', 'cent', 'chi', 'circ', 'clubs', 'cong', 'copy', 'crarr', 'cup', 'curren', 'dArr', 'dagger', 'darr', 'deg', 'delta', 'diams', 'divide', 'eacute', 'ecirc', 'egrave', 'empty', 'emsp', 'ensp', 'epsilon', 'equiv', 'eta', 'eth', 'euml', 'euro', 'exist', 'fnof', 'forall', 'frac12', 'frac14', 'frac34', 'frasl', 'gamma', 'ge', 'gt', 'hArr', 'harr', 'hearts', 'hellip', 'iacute', 'icirc', 'iexcl', 'igrave', 'image', 'infin', 'int', 'iota', 'iquest', 'isin', 'iuml', 'kappa', 'lArr', 'lambda', 'lang', 'laquo', 'larr', 'lceil', 'ldquo', 'le', 'lfloor', 'lowast', 'loz', 'lrm', 'lsaquo', 'lsquo', 'lt', 'macr', 'mdash', 'micro', 'middot', 'minus', 'mu', 'nabla', 'nbsp', 'ndash', 'ne', 'ni', 'not', 'notin', 'nsub', 'ntilde', 'nu', 'oacute', 'ocirc', 'oelig', 'ograve', 'oline', 'omega', 'omicron', 'oplus', 'or', 'ordf', 'ordm', 'oslash', 'otilde', 'otimes', 'ouml', 'para', 'part', 'permil', 'perp', 'phi', 'pi', 'piv', 'plusmn', 'pound', 'prime', 'prod', 'prop', 'psi', 'quot', 'rArr', 'radic', 'rang', 'raquo', 'rarr', 'rceil', 'rdquo', 'real', 'reg', 'rfloor', 'rho', 'rlm', 'rsaquo', 'rsquo', 'sbquo', 'scaron', 'sdot', 'sect', 'shy', 'sigma', 'sigmaf', 'sim', 'spades', 'sub', 'sube', 'sum', 'sup', 'sup1', 'sup2', 'sup3', 'supe', 'szlig', 'tau', 'there4', 'theta', 'thetasym', 'thinsp', 'thorn', 'tilde', 'times', 'trade', 'uArr', 'uacute', 'uarr', 'ucirc', 'ugrave', 'uml', 'upsih', 'upsilon', 'uuml', 'weierp', 'xi', 'yacute', 'yen', 'yuml', 'zeta', 'zwj', 'zwnj'],
\ 'vimxmlroot': ['html'],
\ 'a': [
    \ filter(copy(flow_elements), "!(v:val =~ '". abutton_dec ."')"),
    \ extend(copy(global_attributes), {'name': [], 'href': [], 'target': [], 'rel': linktypes, 'hreflang': lang_tag, 'media': [], 'type': []}) 
\ ],
\ 'abbr': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'address': [
    \ filter(copy(flow_elements), "!(v:val =~ 'address\\|nav\\|article\\|header\\|footer\\|section\\|aside\\|h1\\|h2\\|h3\\|h4\\|h5\\|h6')"),
    \ global_attributes
\ ],
\ 'area': [
    \ [],
    \ extend(copy(global_attributes), {'alt': [], 'href': [], 'target': [], 'rel': linktypes, 'media': [], 'hreflang': lang_tag, 'type': [], 'shape': ['rect', 'circle', 'poly', 'default'], 'coords': []})
\ ],
\ 'article': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'aside': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'audio': [
    \ flow_elements + ['source', 'track'],
    \ extend(copy(global_attributes), {'autoplay': ['autoplay', ''], 'preload': ['none', 'metadata', 'auto', ''], 'controls': ['controls', ''], 'loop': ['loop', ''], 'src': []})
\ ],
\ 'b': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'base': [
    \ [],
    \ extend(copy(global_attributes), {'href': [], 'target': []})
\ ],
\ 'bdo': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'bdi': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'blockquote': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'cite': []})
\ ],
\ 'body': [
    \ flow_elements,
    \ extend(copy(global_attributes), body_attributes)
\ ],
\ 'br': [
    \ [],
    \ global_attributes
\ ],
\ 'button': [
    \ filter(copy(phrasing_elements), "!(v:val =~ '". abutton_dec ."')"),
    \ extend(copy(global_attributes), {'type': ['submit', 'reset', 'button'], 'name': [], 'disabled': ['disabled', ''], 'form': [], 'value': [], 'formaction': [], 'autofocus': ['autofocus', ''], 'formenctype': ['application/x-www-form-urlencoded', 'multipart/form-data', 'text/plain'], 'formmethod': ['get', 'post', 'put', 'delete'], 'formtarget': [], 'formnovalidate': ['formnovalidate', '']})
\ ],
\ 'canvas': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'height': [], 'width': []})
\ ],
\ 'caption': [
    \ filter(copy(flow_elements), "!(v:val =~ 'table')"),
    \ global_attributes
\ ],
\ 'cite': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'code': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'col': [
    \ [],
    \ extend(copy(global_attributes), {'span': []})
\ ],
\ 'colgroup': [
    \ [],
    \ extend(copy(global_attributes), {'span': []})
\ ],
\ 'command': [
    \ ['col'],
    \ extend(copy(global_attributes), {'type': ['command', 'radio', 'checkbox'], 'radiogroup': [], 'checked': ['checked', ''], 'label': [], 'icon': [], 'disabled': ['disabled', '']})
\ ],
\ 'datalist': [
    \ phrasing_elements + ['option'],
    \ global_attributes
\ ],
\ 'dd': [
    \ flow_elements,
    \ global_attributes
\ ],
\ 'del': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'cite': [], 'datetime': []})
\ ],
\ 'details': [
    \ flow_elements + ['summary'],
    \ extend(copy(global_attributes), {'open': ['open', '']})
\ ],
\ 'dfn': [
    \ filter(copy(phrasing_elements), "!(v:val =~ 'dfn')"),
    \ global_attributes
\ ],
\ 'div': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'dl': [
    \ ['dt', 'dd'],
    \ global_attributes
\ ],
\ 'dt': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'em': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'embed': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'type': [], 'height': [], 'width': []})
\ ],
\ 'fieldset': [
    \ flow_elements + ['legend'],
    \ extend(copy(global_attributes), {'name': [], 'disabled': ['disabled', ''], 'form': []})
\ ],
\ 'figcaption': [
    \ flow_elements,
    \ global_attributes
\ ],
\ 'figure': [
    \ flow_elements + ['figcaption'],
    \ global_attributes
\ ],
\ 'footer': [
    \ filter(copy(flow_elements), "!(v:val =~ 'address\\|header\\|footer')"),
    \ global_attributes
\ ],
\ 'form': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'name': [], 'action': [], 'enctype': ['application/x-www-form-urlencoded', 'multipart/form-data', 'text/plain'], 'method': ['get', 'post', 'put', 'delete'], 'target': [], 'novalidate': ['novalidate', ''], 'accept-charset': charset, 'autocomplete': ['on', 'off']})
\ ],
\ 'h1': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h2': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h3': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h4': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h5': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'h6': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'head': [
    \ metadata_elements + ['title', 'base'],
    \ global_attributes
\ ],
\ 'header': [
    \ filter(copy(flow_elements), "!(v:val =~ 'address\\|header\\|footer')"),
    \ global_attributes
\ ],
\ 'hgroup': [
    \ ['h1', 'h2', 'h3', 'h4', 'h5', 'h6'],
    \ global_attributes
\ ],
\ 'hr': [
    \ [],
    \ global_attributes
\ ],
\ 'html': [
    \ ['head', 'body'],
    \ extend(copy(global_attributes), {'manifest': [], 'version': ['HTML+RDFa 1.1']})
\ ],
\ 'i': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'iframe': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'name': [], 'width': [], 'height': [], 'sandbox': ['allow-same-origin', 'allow-forms', 'allow-scripts'], 'seamless': ['seamless', '']})
\ ],
\ 'img': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'alt': [], 'height': [], 'width': [], 'usemap': [], 'ismap': ['ismap', '']})
\ ],
\ 'input': [
    \ [],
    \ extend(copy(global_attributes), {'type': ['text', 'password', 'checkbox', 'radio', 'button', 'submit', 'reset', 'file', 'hidden', 'image', 'datetime', 'datetime-local', 'date', 'month', 'time', 'week', 'number', 'range', 'email', 'url', 'search', 'tel', 'coloe'], 'name': [], 'disabled': ['disabled', ''], 'form': [], 'maxlength': [], 'readonly': ['readonly', ''], 'size': [], 'value': [], 'autocomplete': ['on', 'off'], 'autofocus': ['autofocus', ''], 'list': [], 'pattern': [], 'required': ['required', ''], 'placeholder': [], 'checked': ['checked'], 'accept': [], 'multiple': ['multiple', ''], 'alt': [], 'src': [], 'height': [], 'width': [], 'min': [], 'max': [], 'step': [], 'formenctype': ['application/x-www-form-urlencoded', 'multipart/form-data', 'text/plain'], 'formmethod': ['get', 'post', 'put', 'delete'], 'formtarget': [], 'formnovalidate': ['formnovalidate', '']})
\ ],
\ 'ins': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'cite': [], 'datetime': []})
\ ],
\ 'kbd': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'keygen': [
    \ [],
    \ extend(copy(global_attributes), {'challenge': [], 'keytype': ['rsa'], 'autofocus': ['autofocus', ''], 'name': [], 'disabled': ['disabled', ''], 'form': []})
\ ],
\ 'label': [
    \ filter(copy(phrasing_elements), "!(v:val =~ 'label')"),
    \ extend(copy(global_attributes), {'for': [], 'form': []})
\ ],
\ 'legend': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'li': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'value': []})
\ ],
\ 'link': [
    \ [],
    \ extend(copy(global_attributes), {'href': [], 'rel': linkreltypes, 'hreflang': lang_tag, 'media': [], 'type': [], 'sizes': ['any']})
\ ],
\ 'map': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'name': []})
\ ],
\ 'mark': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'menu': [
    \ flow_elements + ['li'],
    \ extend(copy(global_attributes), {'type': ['toolbar', 'context'], 'label': []})
\ ],
\ 'meta': [
    \ [],
    \ extend(copy(global_attributes), {'name': [], 'http-equiv': ['refresh', 'default-style', 'content-type'], 'content': [], 'charset': charset})
\ ],
\ 'meter': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'value': [], 'min': [], 'low': [], 'high': [], 'max': [], 'optimum': []})
\ ],
\ 'nav': [
    \ flow_elements,
    \ global_attributes
\ ],
\ 'noscript': [
    \ flow_elements + ['link', 'meta', 'style'],
    \ global_attributes
\ ],
\ 'object': [
    \ flow_elements + ['param'],
    \ extend(copy(global_attributes), {'data': [], 'type': [], 'height': [], 'width': [], 'usemap': [], 'name': [], 'form': []})
\ ],
\ 'ol': [
    \ ['li'],
    \ extend(copy(global_attributes), {'start': [], 'reversed': ['reversed', '']})
\ ],
\ 'optgroup': [
    \ ['option'],
    \ extend(copy(global_attributes), {'label': [], 'disabled': ['disabled', '']})
\ ],
\ 'option': [
    \ [''],
    \ extend(copy(global_attributes), {'disabled': ['disabled', ''], 'selected': ['selected', ''], 'label': [], 'value': []})
\ ],
\ 'output': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'name': [], 'form': [], 'for': []})
\ ],
\ 'p': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'param': [
    \ [],
    \ extend(copy(global_attributes), {'name': [], 'value': []})
\ ],
\ 'pre': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'progress': [
    \ filter(copy(phrasing_elements), "!(v:val =~ 'progress')"),
    \ extend(copy(global_attributes), {'value': [], 'max': []})
\ ],
\ 'q': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'cite': []})
\ ],
\ 'rp': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'rt': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'ruby': [
    \ phrasing_elements + ['rp', 'rt'],
    \ global_attributes
\ ],
\ 'samp': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'script': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'defer': ['defer', ''], 'async': ['async', ''], 'type': [], 'charset': charset})
\ ],
\ 'section': [
    \ flow_elements + ['style'],
    \ global_attributes
\ ],
\ 'select': [
    \ ['optgroup', 'option'],
    \ extend(copy(global_attributes), {'name': [], 'disabled': ['disabled', ''], 'form': [], 'size': [], 'multiple': ['multiple', '']})
\ ],
\ 'small': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'source': [
    \ [],
    \ extend(copy(global_attributes), {'src': [], 'type': [], 'media': []})
\ ],
\ 'span': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'strong': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'style': [
    \ [],
    \ extend(copy(global_attributes), {'type': [], 'media': [], 'scoped': ['scoped', '']})
\ ],
\ 'sub': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'summary': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'sup': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'table': [
    \ ['caption', 'col', 'colgroup', 'thead', 'tfoot', 'tbody', 'tr'],
    \ extend(copy(global_attributes), {'border': []})
\ ],
\ 'tbody': [
    \ ['tr'],
    \ global_attributes
\ ],
\ 'td': [
    \ flow_elements,
    \ extend(copy(global_attributes), {'colspan': [], 'rowspan': [], 'headers': []})
\ ],
\ 'textarea': [
    \ [''],
    \ extend(copy(global_attributes), {'name': [], 'disabled': ['disabled', ''], 'form': [], 'readonly': ['readonly', ''], 'maxlength': [], 'autofocus': ['autofocus', ''], 'required': ['required', ''], 'placeholder': [], 'rows': [], 'wrap': ['hard', 'soft'], 'cols': []})
\ ],
\ 'tfoot': [
    \ ['tr'],
    \ global_attributes
\ ],
\ 'th': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'scope': ['row', 'col', 'rowgroup', 'colgroup'], 'colspan': [], 'rowspan': [], 'headers': []})
\ ],
\ 'thead': [
    \ ['tr'],
    \ global_attributes
\ ],
\ 'time': [
    \ phrasing_elements,
    \ extend(copy(global_attributes), {'datetime': [], 'pubdate': ['pubdate', '']})
\ ],
\ 'title': [
    \ [''],
    \ global_attributes
\ ],
\ 'tr': [
    \ ['th', 'td'],
    \ global_attributes
\ ],
\ 'track': [
    \ [],
    \ extend(copy(global_attributes), {'kind': ['subtitles', 'captions', 'descriptions', 'chapters', 'metadata'], 'src': [], 'charset': charset, 'srclang': lang_tag, 'label': []})
\ ],
\ 'u': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'ul': [
    \ ['li'],
    \ global_attributes
\ ],
\ 'var': [
    \ phrasing_elements,
    \ global_attributes
\ ],
\ 'video': [
    \ flow_elements + ['source', 'track'],
    \ extend(copy(global_attributes), {'autoplay': ['autoplay', ''], 'preload': ['none', 'metadata', 'auto', ''], 'controls': ['controls', ''], 'loop': ['loop', ''], 'poster': [], 'height': [], 'width': [], 'src': []})
\ ],
\ 'wbr': [
    \ [],
    \ global_attributes
\ ],
\ 'vimxmlattrinfo' : attributes_value,
\ 'vimxmltaginfo': {
    \ 'area': ['/>', ''],
    \ 'base': ['/>', ''],
    \ 'br': ['/>', ''],
    \ 'col': ['/>', ''],
    \ 'command': ['/>', ''],
    \ 'embed': ['/>', ''],
    \ 'hr': ['/>', ''],
    \ 'img': ['/>', ''],
    \ 'input': ['/>', ''],
    \ 'keygen': ['/>', ''],
    \ 'link': ['/>', ''],
    \ 'meta': ['/>', ''],
    \ 'param': ['/>', ''],
    \ 'source': ['/>', ''],
    \ 'track': ['/>', ''],
    \ 'wbr': ['/>', ''],
\ },
\ }
autoload/htmlcomplete.vim	[[[1
861
" Vim completion script
" Language:	HTML and XHTML
" Maintainer:	Mikolaj Machowski ( mikmach AT wp DOT pl )
" Last Change:	2006 Oct 19
" Modified:     othree <othree@gmail.com>
" Changes:      Add HTML5, WAI-ARIA support
" Last Change:	2010 Sep 25

if !exists('g:aria_attributes_complete')
    let g:aria_attributes_complete = 1
endif

function! htmlcomplete#CompleteTags(findstart, base)
  if a:findstart
    " locate the start of the word
    let line = getline('.')
    let start = col('.') - 1
	let curline = line('.')
	let compl_begin = col('.') - 2
    while start >= 0 && line[start - 1] =~ '\(\k\|[!:.-]\)'
		let start -= 1
    endwhile
	" Handling of entities {{{
	if start >= 0 && line[start - 1] =~ '&'
		let b:entitiescompl = 1
		let b:compl_context = ''
		return start
	endif
	" }}}
	" Handling of <style> tag {{{
	let stylestart = searchpair('<style\>', '', '<\/style\>', "bnW")
	let styleend   = searchpair('<style\>', '', '<\/style\>', "nW")
	if stylestart != 0 && styleend != 0
		if stylestart <= curline && styleend >= curline
			let start = col('.') - 1
			let b:csscompl = 1
			while start >= 0 && line[start - 1] =~ '\(\k\|-\)'
				let start -= 1
			endwhile
		endif
	endif
	" }}}
	" Handling of <script> tag {{{
	let scriptstart = searchpair('<script\>', '', '<\/script\>', "bnW")
	let scriptend   = searchpair('<script\>', '', '<\/script\>', "nW")
	if scriptstart != 0 && scriptend != 0
		if scriptstart <= curline && scriptend >= curline
			let start = col('.') - 1
			let b:jscompl = 1
			let b:jsrange = [scriptstart, scriptend]
			while start >= 0 && line[start - 1] =~ '\k'
				let start -= 1
			endwhile
			" We are inside of <script> tag. But we should also get contents
			" of all linked external files and (secondary, less probably) other <script> tags
			" This logic could possible be done in separate function - may be
			" reused in events scripting (also with option could be reused for
			" CSS
			let b:js_extfiles = []
			let l = line('.')
			let c = col('.')
			call cursor(1,1)
			while search('<\@<=script\>', 'W') && line('.') <= l
				if synIDattr(synID(line('.'),col('.')-1,0),"name") !~? 'comment'
					let sname = matchstr(getline('.'), '<script[^>]*src\s*=\s*\([''"]\)\zs.\{-}\ze\1')
					if filereadable(sname)
						let b:js_extfiles += readfile(sname)
					endif
				endif
			endwhile
			call cursor(1,1)
			let js_scripttags = []
			while search('<script\>', 'W') && line('.') < l
				if matchstr(getline('.'), '<script[^>]*src') == ''
					let js_scripttag = getline(line('.'), search('</script>', 'W'))
					let js_scripttags += js_scripttag
				endif
			endwhile
			let b:js_extfiles += js_scripttags
			call cursor(l,c)
			unlet! l c
		endif
	endif
	" }}}
	if !exists("b:csscompl") && !exists("b:jscompl")
		let b:compl_context = getline('.')[0:(compl_begin)]
		if b:compl_context !~ '<[^>]*$'
			" Look like we may have broken tag. Check previous lines.
			let i = 1
			while 1
				let context_line = getline(curline-i)
				if context_line =~ '<[^>]*$'
					" Yep, this is this line
					let context_lines = getline(curline-i, curline-1) + [b:compl_context]
					let b:compl_context = join(context_lines, ' ')
					break
				elseif context_line =~ '>[^<]*$' || i == curline
					" We are in normal tag line, no need for completion at all
					" OR reached first line without tag at all
					let b:compl_context = ''
					break
				endif
				let i += 1
			endwhile
			" Make sure we don't have counter
			unlet! i
		endif
		let b:compl_context = matchstr(b:compl_context, '.*\zs<.*')

		" Return proper start for on-events. Without that beginning of
		" completion will be badly reported
		if b:compl_context =~? 'on[a-z]*\s*=\s*\(''[^'']*\|"[^"]*\)$'
			let start = col('.') - 1
			while start >= 0 && line[start - 1] =~ '\k'
				let start -= 1
			endwhile
		endif
		" If b:compl_context begins with <? we are inside of PHP code. It
		" wasn't closed so PHP completion passed it to HTML
		if &filetype =~? 'php' && b:compl_context =~ '^<?'
			let b:phpcompl = 1
			let start = col('.') - 1
			while start >= 0 && line[start - 1] =~ '[a-zA-Z_0-9\x7f-\xff$]'
				let start -= 1
			endwhile
		endif
	else
		let b:compl_context = getline('.')[0:compl_begin]
	endif
    return start
  else
	" Initialize base return lists
    let res = []
    let res2 = []
	" a:base is very short - we need context
	let context = b:compl_context
	" Check if we should do CSS completion inside of <style> tag
	" or JS completion inside of <script> tag or PHP completion in case of <?
	" tag AND &ft==php
	if exists("b:csscompl")
		unlet! b:csscompl
		let context = b:compl_context
		unlet! b:compl_context
		return csscomplete#CompleteCSS(0, context)
	elseif exists("b:jscompl")
		unlet! b:jscompl
		return javascriptcomplete#CompleteJS(0, a:base)
	elseif exists("b:phpcompl")
		unlet! b:phpcompl
		let context = b:compl_context
		return phpcomplete#CompletePHP(0, a:base)
	else
		if len(b:compl_context) == 0 && !exists("b:entitiescompl")
			return []
		endif
		let context = matchstr(b:compl_context, '.\zs.*')
	endif
	unlet! b:compl_context
	" Entities completion {{{
	if exists("b:entitiescompl")
		unlet! b:entitiescompl

		if !exists("b:html_doctype")
			call htmlcomplete#CheckDoctype()
		endif
		if !exists("b:html_omni")
			"runtime! autoload/xml/xhtml10s.vim
			call htmlcomplete#LoadData()
		endif
        if g:aria_attributes_complete == 1 && !exists("b:aria_omni")
            call htmlcomplete#LoadAria()
        endif

	    let entities =  b:html_omni['vimxmlentities']

		if len(a:base) == 1
			for m in entities
				if m =~ '^'.a:base
					call add(res, m.';')
				endif
			endfor
			return res
		else
			for m in entities
				if m =~? '^'.a:base
					call add(res, m.';')
				elseif m =~? a:base
					call add(res2, m.';')
				endif
			endfor

			return res + res2
		endif


	endif
	" }}}
	if context =~ '>'
		" Generally if context contains > it means we are outside of tag and
		" should abandon action - with one exception: <style> span { bo
		if context =~ 'style[^>]\{-}>[^<]\{-}$'
			return csscomplete#CompleteCSS(0, context)
		elseif context =~ 'script[^>]\{-}>[^<]\{-}$'
			let b:jsrange = [line('.'), search('<\/script\>', 'nW')]
			return javascriptcomplete#CompleteJS(0, context)
		else
			return []
		endif
	endif

	" If context contains > it means we are already outside of tag and we
	" should abandon action
	" If context contains white space it is attribute.
	" It can be also value of attribute.
	" We have to get first word to offer proper completions
	if context == ''
		let tag = ''
	else
		let tag = split(context)[0]
		" Detect if tag is uppercase to return in proper case,
		" we need to make it lowercase for processing
		if tag =~ '^\u*$'
			let uppercase_tag = 1
			let tag = tolower(tag)
		else
			let uppercase_tag = 0
		endif
	endif
	" Get last word, it should be attr name
	let attr = matchstr(context, '\S\+="[^"]*$')
    if attr == ''
        let attr = matchstr(context, '.*\s\zs.*')
    endif
	" Possible situations where any prediction would be difficult:
	" 1. Events attributes
	if context =~ '\s'
		" Sort out style, class, and on* cases
		if context =~? "\\s\\(on[a-z]+\\|id\\|style\\|class\\)\\s*=\\s*[\"']"
			" Id, class completion {{{
			if context =~? "\\(id\\|class\\)\\s*=\\s*[\"'][a-zA-Z0-9_ -]*$"
				if context =~? "class\\s*=\\s*[\"'][a-zA-Z0-9_ -]*$"
					let search_for = "class"
				elseif context =~? "id\\s*=\\s*[\"'][a-zA-Z0-9_ -]*$"
					let search_for = "id"
				endif
				" Handle class name completion
				" 1. Find lines of <link stylesheet>
				" 1a. Check file for @import
				" 2. Extract filename(s?) of stylesheet,
				call cursor(1,1)
				let head = getline(search('<head\>'), search('<\/head>'))
				let headjoined = join(copy(head), ' ')
				if headjoined =~ '<style'
					" Remove possibly confusing CSS operators
					let stylehead = substitute(headjoined, '+>\*[,', ' ', 'g')
					if search_for == 'class'
						let styleheadlines = split(stylehead)
						let headclasslines = filter(copy(styleheadlines), "v:val =~ '\\([a-zA-Z0-9:]\\+\\)\\?\\.[a-zA-Z0-9_-]\\+'")
					else
						let stylesheet = split(headjoined, '[{}]')
						" Get all lines which fit id syntax
						let classlines = filter(copy(stylesheet), "v:val =~ '#[a-zA-Z0-9_-]\\+'")
						" Filter out possible color definitions
						call filter(classlines, "v:val !~ ':\\s*#[a-zA-Z0-9_-]\\+'")
						" Filter out complex border definitions
						call filter(classlines, "v:val !~ '\\(none\\|hidden\\|dotted\\|dashed\\|solid\\|double\\|groove\\|ridge\\|inset\\|outset\\)\\s*#[a-zA-Z0-9_-]\\+'")
						let templines = join(classlines, ' ')
						let headclasslines = split(templines)
						call filter(headclasslines, "v:val =~ '#[a-zA-Z0-9_-]\\+'")
					endif
					let internal = 1
				else
					let internal = 0
				endif
				let styletable = []
				let secimportfiles = []
				let filestable = filter(copy(head), "v:val =~ '\\(@import\\|link.*stylesheet\\)'")
				for line in filestable
					if line =~ "@import"
						let styletable += [matchstr(line, "import\\s\\+\\(url(\\)\\?[\"']\\?\\zs\\f\\+\\ze")]
					elseif line =~ "<link"
						let styletable += [matchstr(line, "href\\s*=\\s*[\"']\\zs\\f\\+\\ze")]
					endif
				endfor
				for file in styletable
					if filereadable(file)
						let stylesheet = readfile(file)
						let secimport = filter(copy(stylesheet), "v:val =~ '@import'")
						if len(secimport) > 0
							for line in secimport
								let secfile = matchstr(line, "import\\s\\+\\(url(\\)\\?[\"']\\?\\zs\\f\\+\\ze")
								let secfile = fnamemodify(file, ":p:h").'/'.secfile
								let secimportfiles += [secfile]
							endfor
						endif
					endif
				endfor
				let cssfiles = styletable + secimportfiles
				let classes = []
				for file in cssfiles
					if filereadable(file)
						let stylesheet = readfile(file)
						let stylefile = join(stylesheet, ' ')
						let stylefile = substitute(stylefile, '+>\*[,', ' ', 'g')
						if search_for == 'class'
							let stylesheet = split(stylefile)
							let classlines = filter(copy(stylesheet), "v:val =~ '\\([a-zA-Z0-9:]\\+\\)\\?\\.[a-zA-Z0-9_-]\\+'")
						else
							let stylesheet = split(stylefile, '[{}]')
							" Get all lines which fit id syntax
							let classlines = filter(copy(stylesheet), "v:val =~ '#[a-zA-Z0-9_-]\\+'")
							" Filter out possible color definitions
							call filter(classlines, "v:val !~ ':\\s*#[a-zA-Z0-9_-]\\+'")
							" Filter out complex border definitions
							call filter(classlines, "v:val !~ '\\(none\\|hidden\\|dotted\\|dashed\\|solid\\|double\\|groove\\|ridge\\|inset\\|outset\\)\\s*#[a-zA-Z0-9_-]\\+'")
							let templines = join(classlines, ' ')
							let stylelines = split(templines)
							let classlines = filter(stylelines, "v:val =~ '#[a-zA-Z0-9_-]\\+'")

						endif
                        " We gathered classes definitions from all external files
                        let classes += classlines
					endif
				endfor
				if internal == 1
					let classes += headclasslines
				endif

				if search_for == 'class'
					let elements = {}
					for element in classes
						if element =~ '^\.'
							let class = matchstr(element, '^\.\zs[a-zA-Z][a-zA-Z0-9_-]*\ze')
							let class = substitute(class, ':.*', '', '')
							if has_key(elements, 'common')
								let elements['common'] .= ' '.class
							else
								let elements['common'] = class
							endif
						else
							let class = matchstr(element, '[a-zA-Z1-6]*\.\zs[a-zA-Z][a-zA-Z0-9_-]*\ze')
							let tagname = tolower(matchstr(element, '[a-zA-Z1-6]*\ze.'))
							if tagname != ''
								if has_key(elements, tagname)
									let elements[tagname] .= ' '.class
								else
									let elements[tagname] = class
								endif
							endif
						endif
					endfor

					if has_key(elements, tag) && has_key(elements, 'common')
						let values = split(elements[tag]." ".elements['common'])
					elseif has_key(elements, tag) && !has_key(elements, 'common')
						let values = split(elements[tag])
					elseif !has_key(elements, tag) && has_key(elements, 'common')
						let values = split(elements['common'])
					else
						return []
					endif

				elseif search_for == 'id'
					" Find used IDs
					" 1. Catch whole file
					let filelines = getline(1, line('$'))
					" 2. Find lines with possible id
					let used_id_lines = filter(filelines, 'v:val =~ "id\\s*=\\s*[\"''][a-zA-Z0-9_-]\\+"')
					" 3a. Join all filtered lines
					let id_string = join(used_id_lines, ' ')
					" 3b. And split them to be sure each id is in separate item
					let id_list = split(id_string, 'id\s*=\s*')
					" 4. Extract id values
					let used_id = map(id_list, 'matchstr(v:val, "[\"'']\\zs[a-zA-Z0-9_-]\\+\\ze")')
					let joined_used_id = ','.join(used_id, ',').','

					let allvalues = map(classes, 'matchstr(v:val, ".*#\\zs[a-zA-Z0-9_-]\\+")')

					let values = []

					for element in classes
						if joined_used_id !~ ','.element.','
							let values += [element]
						endif

					endfor

				endif

				" We need special version of sbase
				let classbase = matchstr(context, ".*[\"']")
				let classquote = matchstr(classbase, '.$')

				let entered_class = matchstr(attr, ".*=\\s*[\"']\\zs.*")

				for m in sort(values)
					if m =~? '^'.entered_class
						call add(res, m . classquote)
					elseif m =~? entered_class
						call add(res2, m . classquote)
					endif
				endfor

				return res + res2

			elseif context =~? "style\\s*=\\s*[\"'][^\"']*$"
				return csscomplete#CompleteCSS(0, context)

			endif
			" }}}
			" Complete on-events {{{
			if context =~? 'on[a-z]*\s*=\s*\(''[^'']*\|"[^"]*\)$'
				" We have to:
				" 1. Find external files
				let b:js_extfiles = []
				let l = line('.')
				let c = col('.')
				call cursor(1,1)
				while search('<\@<=script\>', 'W') && line('.') <= l
					if synIDattr(synID(line('.'),col('.')-1,0),"name") !~? 'comment'
						let sname = matchstr(getline('.'), '<script[^>]*src\s*=\s*\([''"]\)\zs.\{-}\ze\1')
						if filereadable(sname)
							let b:js_extfiles += readfile(sname)
						endif
					endif
				endwhile
				" 2. Find at least one <script> tag
				call cursor(1,1)
				let js_scripttags = []
				while search('<script\>', 'W') && line('.') < l
					if matchstr(getline('.'), '<script[^>]*src') == ''
						let js_scripttag = getline(line('.'), search('</script>', 'W'))
						let js_scripttags += js_scripttag
					endif
				endwhile
				let b:js_extfiles += js_scripttags

				" 3. Proper call for javascriptcomplete#CompleteJS
				call cursor(l,c)
				let js_context = matchstr(a:base, '\k\+$')
				let js_shortcontext = substitute(a:base, js_context.'$', '', '')
				let b:compl_context = context
				let b:jsrange = [l, l]
				unlet! l c
				return javascriptcomplete#CompleteJS(0, js_context)

			endif

			" }}}
			let stripbase = matchstr(context, ".*\\(on[a-zA-Z]*\\|style\\|class\\)\\s*=\\s*[\"']\\zs.*")
			" Now we have context stripped from all chars up to style/class.
			" It may fail with some strange style value combinations.
			if stripbase !~ "[\"']"
				return []
			endif
		endif
		" Value of attribute completion {{{
		" If attr contains =\s*[\"'] we catched value of attribute
		if attr =~ "=\s*[\"']" || attr =~ "=\s*$"
			" Let do attribute specific completion
			let attrname = matchstr(attr, '.*\ze\s*=')
			let entered_value = matchstr(attr, ".*=\\s*[\"']\\?\\zs.*")
			let values = []
			" Load data {{{
			if !exists("b:html_doctype")
				call htmlcomplete#CheckDoctype()
			endif
			if !exists("b:html_omni")
				"runtime! autoload/xml/xhtml10s.vim
				call htmlcomplete#LoadData()
			endif
            if g:aria_attributes_complete == 1 && !exists("b:aria_omni")
                call htmlcomplete#LoadAria()
            endif
			" }}}
			if attrname == 'href'
				" Now we are looking for local anchors defined by name or id
				if entered_value =~ '^#'
					let file = join(getline(1, line('$')), ' ')
					" Split it be sure there will be one id/name element in
					" item, it will be also first word [a-zA-Z0-9_-] in element
					let oneelement = split(file, "\\(meta \\)\\@<!\\(name\\|id\\)\\s*=\\s*[\"']")
					for i in oneelement
						let values += ['#'.matchstr(i, "^[a-zA-Z][a-zA-Z0-9%_-]*")]
					endfor
				endif
			else
				if has_key(b:html_omni, tag) && has_key(b:html_omni[tag][1], attrname)
					let values = b:html_omni[tag][1][attrname]
                elseif attrname =~ '^aria-' && exists("b:aria_omni") && has_key(b:aria_omni['aria_attributes'], attrname)
					let values = b:aria_omni['aria_attributes'][attrname]
				else
					return []
				endif
			endif

			if len(values) == 0
				return []
            endif

			" We need special version of sbase
			let attrbase = matchstr(context, ".*[\"']")
			let attrquote = matchstr(attrbase, '.$')
			if attrquote !~ "['\"]"
				let attrquoteopen = '"'
                let attrquote = '"'
			else
				let attrquoteopen = ''
            endif
            " Multi value attributes don't need ending quote
            let info = ''
            if has_key(b:html_omni['vimxmlattrinfo'], attrname)
                let info = b:html_omni['vimxmlattrinfo'][attrname][0]
            elseif exists("b:aria_omni") && has_key(b:aria_omni['vimariaattrinfo'], attrname)
                let info = b:aria_omni['vimariaattrinfo'][attrname][0]
            endif
            if info =~ "^\\*"
                let attrquote = ''
            endif

            if len(entered_value) > 0
                if entered_value =~ "\\s$"
                    let entered_value = ''
                else
                    let entered_value = split(entered_value)[-1]
                endif
            endif
			for m in values
				" This if is needed to not offer all completions as-is
				" alphabetically but sort them. Those beginning with entered
				" part will be as first choices
				if m =~ '^'.entered_value
					call add(res, attrquoteopen . m . attrquote)
				elseif m =~ entered_value
					call add(res2, attrquoteopen . m . attrquote)
				endif
			endfor

			return res + res2

		endif
		" }}}
		" Attribute completion {{{
		" Shorten context to not include last word
		let sbase = matchstr(context, '.*\ze\s.*')

		" Load data {{{
		if !exists("b:html_doctype")
			call htmlcomplete#CheckDoctype()
		endif
		if !exists("b:html_omni")
			call htmlcomplete#LoadData()
		endif
        if g:aria_attributes_complete == 1 && !exists("b:aria_omni")
            call htmlcomplete#LoadAria()
        endif
		" }}}

		if has_key(b:html_omni, tag)
			let attrs = keys(b:html_omni[tag][1])
		else
			return []
        endif
        if exists("b:aria_omni")
            let roles = []
            if has_key(b:aria_omni['default_role'], tag)
                let roles = [b:aria_omni['default_role'][tag]]
            endif
            if context =~ 'role='
                let start = matchend(context, "role=['\"]")
                let end   = matchend(context, "[a-z ]\\+['\"]", start)
                if start != -1 && end != -1
                    let roles = split(strpart(context, start, end-start-1), " ")
                endif
            endif
            for i in range(len(roles))
                let role = roles[i]
                if has_key(b:aria_omni['role_attributes'], role)
                    let attrs = extend(attrs, b:aria_omni['role_attributes'][role])
                endif
            endfor
        endif

		for m in sort(attrs)
			if m =~ '^'.attr
				call add(res, m)
			elseif m =~ attr
				call add(res2, m)
			endif
		endfor
		"let menu = res + res2
		let menu = res
		if has_key(b:html_omni, 'vimxmlattrinfo') || (exists("b:aria_omni") && has_key(b:aria_omni, 'vimariaattrinfo'))
			let final_menu = []
			for i in range(len(menu))
				let item = menu[i]
				if has_key(b:html_omni['vimxmlattrinfo'], item)
					let m_menu = b:html_omni['vimxmlattrinfo'][item][0]
					let m_info = b:html_omni['vimxmlattrinfo'][item][1]
                elseif exists("b:aria_omni") && has_key(b:aria_omni['vimariaattrinfo'], item)
					let m_menu = b:aria_omni['vimariaattrinfo'][item][0]
					let m_info = b:aria_omni['vimariaattrinfo'][item][1]
                else
					let m_menu = ''
					let m_info = ''
                endif
                if item =~ '^aria-' && exists("b:aria_omni")
                    if len(b:aria_omni['aria_attributes'][item]) > 0 && b:aria_omni['aria_attributes'][item][0] =~ '^\(BOOL\|'.item.'\)$'
                        let item = item
                        let m_menu = 'Bool'
                    else
                        let item .= '="'
                    endif
                else
                    if len(b:html_omni[tag][1][item]) > 0 && b:html_omni[tag][1][item][0] =~ '^\(BOOL\|'.item.'\)$'
                        let item = item
                        let m_menu = 'Bool'
                    else
                        let item .= '="'
                    endif
                endif
				let final_menu += [{'word':item, 'menu':m_menu, 'info':m_info}]
			endfor
		else
			let final_menu = []
			for i in range(len(menu))
				let item = menu[i]
				if len(b:html_omni[tag][1][item]) > 0 && b:html_omni[tag][1][item][0] =~ '^\(BOOL\|'.item.'\)$'
					let item = item
				else
					let item .= '="'
				endif
				let final_menu += [item]
			endfor
			return final_menu

		endif
		return final_menu

	endif
	" }}}
	" Close tag {{{
	let b:unaryTagsStack = "area base br col command embed hr img input keygen link meta param source track wbr"
	if context =~ '^\/'
		if context =~ '^\/.'
			return []
		else
			let opentag = xmlcomplete#GetLastOpenTag("b:unaryTagsStack")
			return [opentag.">"]
		endif
	endif
	" }}}
	" Load data {{{
	if !exists("b:html_doctype")
		call htmlcomplete#CheckDoctype()
	endif
	if !exists("b:html_omni")
		"runtime! autoload/xml/xhtml10s.vim
		call htmlcomplete#LoadData()
	endif
    if g:aria_attributes_complete == 1 && !exists("b:aria_omni")
        call htmlcomplete#LoadAria()
    endif
	" }}}
	" Tag completion {{{
	" Deal with tag completion.
	let opentag = tolower(xmlcomplete#GetLastOpenTag("b:unaryTagsStack"))
	" MM: TODO: GLOT works always the same but with some weird situation it
	" behaves as intended in HTML but screws in PHP
	if opentag == '' || &filetype == 'php' && !has_key(b:html_omni, opentag)
		" Hack for sometimes failing GetLastOpenTag.
		" As far as I tested fail isn't GLOT fault but problem
		" of invalid document - not properly closed tags and other mish-mash.
		" Also when document is empty. Return list of *all* tags.
	    let tags = keys(b:html_omni)
		call filter(tags, 'v:val !~ "^vimxml"')
	else
		if has_key(b:html_omni, opentag)
			let tags = b:html_omni[opentag][0]
		else
			return []
		endif
	endif
	" }}}

	if exists("uppercase_tag") && uppercase_tag == 1
		let context = tolower(context)
	endif
	" Handle XML keywords: DOCTYPE
	if opentag == ''
		let tags = [
				\ '!DOCTYPE html>',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Frameset//EN" "http://www.w3.org/TR/REC-html40/frameset.dtd">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">',
				\ '!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/1999/xhtml">'
				\ ] + sort(tags)
	endif

	"for m in sort(tags)
	for m in tags
		if m =~ '^'.context
			call add(res, m)
		elseif m =~ context
			call add(res2, m)
		endif
	endfor
	let menu = res + res2
	if has_key(b:html_omni, 'vimxmltaginfo')
		let final_menu = []
		for i in range(len(menu))
			let item = menu[i]
			if has_key(b:html_omni['vimxmltaginfo'], item)
				let m_menu = b:html_omni['vimxmltaginfo'][item][0]
				let m_info = b:html_omni['vimxmltaginfo'][item][1]
			else
				let m_menu = ''
				let m_info = ''
			endif
			if &filetype == 'html' && exists("uppercase_tag") && uppercase_tag == 1 && item !~ 'DOCTYPE'
				let item = toupper(item)
			endif
			if item =~ 'DOCTYPE'
                if item =~ 'DTD'
                    let abbr = 'DOCTYPE '.matchstr(item, 'DTD \zsX\?HTML .\{-}\ze\/\/')
                else
                    let abbr = 'DOCTYPE HTML 5'
                endif
			else
				let abbr = item
			endif
			let final_menu += [{'abbr':abbr, 'word':item, 'menu':m_menu, 'info':m_info}]
		endfor
	else
		let final_menu = menu
	endif
	return final_menu

	" }}}
  endif
endfunction

function! htmlcomplete#LoadAria() " {{{
    runtime! autoload/xml/aria.vim
    if exists("g:xmldata_aria")
        \ && has_key(g:xmldata_aria, 'default_role') 
        \ && has_key(g:xmldata_aria, 'role_attributes') 
        \ && has_key(g:xmldata_aria, 'vimariaattrinfo')
        \ && has_key(g:xmldata_aria, 'aria_attributes')
        let b:aria_omni = g:xmldata_aria
    else
        let g:aria_attributes_complete = 0
    endif
endfunction
" }}}
function! htmlcomplete#LoadData() " {{{
	if !exists("b:html_omni_flavor")
		if &filetype == 'html'
			let b:html_omni_flavor = 'html401t'
		else
			let b:html_omni_flavor = 'xhtml10s'
		endif
	endif
	" With that if we still have bloated memory but create new buffer
	" variables only by linking to existing g:variable, not sourcing whole
	" file.
	if exists('g:xmldata_'.b:html_omni_flavor)
		exe 'let b:html_omni = g:xmldata_'.b:html_omni_flavor
	else
		exe 'runtime! autoload/xml/'.b:html_omni_flavor.'.vim'
		exe 'let b:html_omni = g:xmldata_'.b:html_omni_flavor
	endif
endfunction
" }}}
function! htmlcomplete#CheckDoctype() " {{{
	if exists('b:html_omni_flavor')
		let old_flavor = b:html_omni_flavor
	else
		let old_flavor = ''
	endif
	let i = 1
	while i < 10 && i < line("$")
		let line = getline(i)
		if line =~ '<!DOCTYPE.*\<DTD HTML 3\.2'
			let b:html_omni_flavor = 'html32'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD HTML 4\.0 Transitional'
			let b:html_omni_flavor = 'html40t'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD HTML 4\.0 Frameset'
			let b:html_omni_flavor = 'html40f'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD HTML 4\.0'
			let b:html_omni_flavor = 'html40s'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD HTML 4\.01 Transitional'
			let b:html_omni_flavor = 'html401t'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD HTML 4\.01 Frameset'
			let b:html_omni_flavor = 'html401f'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD HTML 4\.01'
			let b:html_omni_flavor = 'html401s'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD XHTML 1\.0 Transitional'
			let b:html_omni_flavor = 'xhtml10t'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD XHTML 1\.0 Frameset'
			let b:html_omni_flavor = 'xhtml10f'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD XHTML 1\.0 Strict'
			let b:html_omni_flavor = 'xhtml10s'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE.*\<DTD XHTML 1\.1'
			let b:html_omni_flavor = 'xhtml11'
			let b:html_doctype = 1
			break
		elseif line =~ '<!DOCTYPE html'
			let b:html_omni_flavor = 'html5'
			let b:html_doctype = 1
			break
		endif
		let i += 1
	endwhile
	if !exists("b:html_doctype")
		return
	else
		" Tie g:xmldata with b:html_omni this way we need to sourca data file only
		" once, not every time per buffer.
		if old_flavor == b:html_omni_flavor
			return
		else
			if exists('g:xmldata_'.b:html_omni_flavor)
				exe 'let b:html_omni = g:xmldata_'.b:html_omni_flavor
			else
				exe 'runtime! autoload/xml/'.b:html_omni_flavor.'.vim'
				exe 'let b:html_omni = g:xmldata_'.b:html_omni_flavor
			endif
			return
		endif
	endif
endfunction
" }}}
" vim:set foldmethod=marker:
indent/html.vim	[[[1
281
" Description:	html5 (and html4) indenter
" Changed By:	Brian Gershon <brian.five@gmail.com>
" Last Change:	30 Jan 2011
" 
"   1. Started with vim72 html indent file authored by Johannes Zellner (below)
"   2. Added html5 list as described here:
"      http://stackoverflow.com/questions/3232518/how-to-update-vim-to-color-code-new-html-elements
"   3. Added this to a fork of https://github.com/othree/html5.vim
"      which already provides nice html5 syntax highlighting.
"
" Description:	html indenter
" Author:	Johannes Zellner <johannes@zellner.org>
" Last Change:	Mo, 05 Jun 2006 22:32:41 CEST
" 		Restoring 'cpo' and 'ic' added by Bram 2006 May 5
" Globals:	g:html_indent_tags	   -- indenting tags
"		g:html_indent_strict       -- inhibit 'O O' elements
"		g:html_indent_strict_table -- inhibit 'O -' elements

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1


" [-- local settings (must come before aborting the script) --]
setlocal indentexpr=HtmlIndentGet(v:lnum)
setlocal indentkeys=o,O,*<Return>,<>>,{,}


if exists('g:html_indent_tags')
    unlet g:html_indent_tags
endif

" [-- helper function to assemble tag list --]
fun! <SID>HtmlIndentPush(tag)
    if exists('g:html_indent_tags')
	let g:html_indent_tags = g:html_indent_tags.'\|'.a:tag
    else
	let g:html_indent_tags = a:tag
    endif
endfun


" [-- <ELEMENT ? - - ...> --]
call <SID>HtmlIndentPush('a')
call <SID>HtmlIndentPush('abbr')
call <SID>HtmlIndentPush('acronym')
call <SID>HtmlIndentPush('address')
call <SID>HtmlIndentPush('b')
call <SID>HtmlIndentPush('bdo')
call <SID>HtmlIndentPush('big')
call <SID>HtmlIndentPush('blockquote')
call <SID>HtmlIndentPush('button')
call <SID>HtmlIndentPush('caption')
call <SID>HtmlIndentPush('center')
call <SID>HtmlIndentPush('cite')
call <SID>HtmlIndentPush('code')
call <SID>HtmlIndentPush('colgroup')
call <SID>HtmlIndentPush('del')
call <SID>HtmlIndentPush('dfn')
call <SID>HtmlIndentPush('dir')
call <SID>HtmlIndentPush('div')
call <SID>HtmlIndentPush('dl')
call <SID>HtmlIndentPush('em')
call <SID>HtmlIndentPush('fieldset')
call <SID>HtmlIndentPush('font')
call <SID>HtmlIndentPush('form')
call <SID>HtmlIndentPush('frameset')
call <SID>HtmlIndentPush('h1')
call <SID>HtmlIndentPush('h2')
call <SID>HtmlIndentPush('h3')
call <SID>HtmlIndentPush('h4')
call <SID>HtmlIndentPush('h5')
call <SID>HtmlIndentPush('h6')
call <SID>HtmlIndentPush('i')
call <SID>HtmlIndentPush('iframe')
call <SID>HtmlIndentPush('ins')
call <SID>HtmlIndentPush('kbd')
call <SID>HtmlIndentPush('label')
call <SID>HtmlIndentPush('legend')
call <SID>HtmlIndentPush('map')
call <SID>HtmlIndentPush('menu')
call <SID>HtmlIndentPush('noframes')
call <SID>HtmlIndentPush('noscript')
call <SID>HtmlIndentPush('object')
call <SID>HtmlIndentPush('ol')
call <SID>HtmlIndentPush('optgroup')
" call <SID>HtmlIndentPush('pre')
call <SID>HtmlIndentPush('q')
call <SID>HtmlIndentPush('s')
call <SID>HtmlIndentPush('samp')
call <SID>HtmlIndentPush('script')
call <SID>HtmlIndentPush('select')
call <SID>HtmlIndentPush('small')
call <SID>HtmlIndentPush('span')
call <SID>HtmlIndentPush('strong')
call <SID>HtmlIndentPush('style')
call <SID>HtmlIndentPush('sub')
call <SID>HtmlIndentPush('sup')
call <SID>HtmlIndentPush('table')
call <SID>HtmlIndentPush('textarea')
call <SID>HtmlIndentPush('title')
call <SID>HtmlIndentPush('tt')
call <SID>HtmlIndentPush('u')
call <SID>HtmlIndentPush('ul')
call <SID>HtmlIndentPush('var')

" New HTML 5 elements
call <SID>HtmlIndentPush('article')
call <SID>HtmlIndentPush('aside')
call <SID>HtmlIndentPush('audio')
call <SID>HtmlIndentPush('canvas')
call <SID>HtmlIndentPush('command')
call <SID>HtmlIndentPush('datalist')
call <SID>HtmlIndentPush('details')
call <SID>HtmlIndentPush('embed')
call <SID>HtmlIndentPush('figcaption')
call <SID>HtmlIndentPush('figure')
call <SID>HtmlIndentPush('footer')
call <SID>HtmlIndentPush('header')
call <SID>HtmlIndentPush('hgroup')
call <SID>HtmlIndentPush('keygen')
call <SID>HtmlIndentPush('mark')
call <SID>HtmlIndentPush('meter')
call <SID>HtmlIndentPush('nav')
call <SID>HtmlIndentPush('output')
call <SID>HtmlIndentPush('progress')
call <SID>HtmlIndentPush('rp')
call <SID>HtmlIndentPush('rt')
call <SID>HtmlIndentPush('ruby')
call <SID>HtmlIndentPush('section')
call <SID>HtmlIndentPush('source')
call <SID>HtmlIndentPush('summary')
call <SID>HtmlIndentPush('time')
call <SID>HtmlIndentPush('video')
call <SID>HtmlIndentPush('bdi')

" [-- <ELEMENT ? O O ...> --]
if !exists('g:html_indent_strict')
    call <SID>HtmlIndentPush('body')
    call <SID>HtmlIndentPush('head')
    call <SID>HtmlIndentPush('html')
    call <SID>HtmlIndentPush('tbody')
endif


" [-- <ELEMENT ? O - ...> --]
if !exists('g:html_indent_strict_table')
    call <SID>HtmlIndentPush('th')
    call <SID>HtmlIndentPush('td')
    call <SID>HtmlIndentPush('tr')
    call <SID>HtmlIndentPush('tfoot')
    call <SID>HtmlIndentPush('thead')
endif

delfun <SID>HtmlIndentPush

let s:cpo_save = &cpo
set cpo-=C

" [-- count indent-increasing tags of line a:lnum --]
fun! <SID>HtmlIndentOpen(lnum, pattern)
    let s = substitute('x'.getline(a:lnum),
    \ '.\{-}\(\(<\)\('.a:pattern.'\)\>\)', "\1", 'g')
    let s = substitute(s, "[^\1].*$", '', '')
    return strlen(s)
endfun

" [-- count indent-decreasing tags of line a:lnum --]
fun! <SID>HtmlIndentClose(lnum, pattern)
    let s = substitute('x'.getline(a:lnum),
    \ '.\{-}\(\(<\)/\('.a:pattern.'\)\>>\)', "\1", 'g')
    let s = substitute(s, "[^\1].*$", '', '')
    return strlen(s)
endfun

" [-- count indent-increasing '{' of (java|css) line a:lnum --]
fun! <SID>HtmlIndentOpenAlt(lnum)
    return strlen(substitute(getline(a:lnum), '[^{]\+', '', 'g'))
endfun

" [-- count indent-decreasing '}' of (java|css) line a:lnum --]
fun! <SID>HtmlIndentCloseAlt(lnum)
    return strlen(substitute(getline(a:lnum), '[^}]\+', '', 'g'))
endfun

" [-- return the sum of indents respecting the syntax of a:lnum --]
fun! <SID>HtmlIndentSum(lnum, style)
    if a:style == match(getline(a:lnum), '^\s*</')
	if a:style == match(getline(a:lnum), '^\s*</\<\('.g:html_indent_tags.'\)\>')
	    let open = <SID>HtmlIndentOpen(a:lnum, g:html_indent_tags)
	    let close = <SID>HtmlIndentClose(a:lnum, g:html_indent_tags)
	    if 0 != open || 0 != close
		return open - close
	    endif
	endif
    endif
    if '' != &syntax &&
	\ synIDattr(synID(a:lnum, 1, 1), 'name') =~ '\(css\|java\).*' &&
	\ synIDattr(synID(a:lnum, strlen(getline(a:lnum)), 1), 'name')
	\ =~ '\(css\|java\).*'
	if a:style == match(getline(a:lnum), '^\s*}')
	    return <SID>HtmlIndentOpenAlt(a:lnum) - <SID>HtmlIndentCloseAlt(a:lnum)
	endif
    endif
    return 0
endfun

fun! HtmlIndentGet(lnum)
    " Find a non-empty line above the current line.
    let lnum = prevnonblank(a:lnum - 1)

    " Hit the start of the file, use zero indent.
    if lnum == 0
	return 0
    endif

    let restore_ic = &ic
    setlocal ic " ignore case

    " [-- special handling for <pre>: no indenting --]
    if getline(a:lnum) =~ '\c</pre>'
		\ || 0 < searchpair('\c<pre>', '', '\c</pre>', 'nWb')
		\ || 0 < searchpair('\c<pre>', '', '\c</pre>', 'nW')
	" we're in a line with </pre> or inside <pre> ... </pre>
	if restore_ic == 0
	  setlocal noic
	endif
	return -1
    endif

    " [-- special handling for <javascript>: use cindent --]
    let js = '<script.*type\s*=\s*.*java'

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " by Tye Zdrojewski <zdro@yahoo.com>, 05 Jun 2006
    " ZDR: This needs to be an AND (we are 'after the start of the pair' AND
    "      we are 'before the end of the pair').  Otherwise, indentation
    "      before the start of the script block will be affected; the end of
    "      the pair will still match if we are before the beginning of the
    "      pair.
    "
    if   0 < searchpair(js, '', '</script>', 'nWb')
    \ && 0 < searchpair(js, '', '</script>', 'nW')
	" we're inside javascript
	if getline(lnum) !~ js && getline(a:lnum) != '</script>'
	    if restore_ic == 0
	      setlocal noic
	    endif
	    return cindent(a:lnum)
	endif
    endif

    if getline(lnum) =~ '\c</pre>'
	" line before the current line a:lnum contains
	" a closing </pre>. --> search for line before
	" starting <pre> to restore the indent.
	let preline = prevnonblank(search('\c<pre>', 'bW') - 1)
	if preline > 0
	    if restore_ic == 0
	      setlocal noic
	    endif
	    return indent(preline)
	endif
    endif

    let ind = <SID>HtmlIndentSum(lnum, -1)
    let ind = ind + <SID>HtmlIndentSum(a:lnum, 0)

    if restore_ic == 0
	setlocal noic
    endif

    return indent(lnum) + (&sw * ind)
endfun

let &cpo = s:cpo_save
unlet s:cpo_save

" [-- EOF <runtime>/indent/html.vim --]
syntax/javascript/html5.vim	[[[1
40
" Vim syntax file
" Language:	    HTML5 New Stuff
" Maintainer:	othree <othree@gmail.com>
" URL:		    http://github.com/othree/html5-syntax.vim
" Last Change:  2011-05-27
" License:      MIT
" Changes:      

syn keyword javaScriptHtmlEvents onabort onblur oncanplay oncanplaythrough onchange 
syn keyword javaScriptHtmlEvents onclick oncontextmenu ondblclick ondrag ondragend ondragenter ondragleave ondragover 
syn keyword javaScriptHtmlEvents ondragstart ondrop ondurationchange onemptied onended onerror onfocus onformchange 
syn keyword javaScriptHtmlEvents onforminput oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata 
syn keyword javaScriptHtmlEvents onloadedmetadata onloadstart onmousedown onmousemove onmouseout onmouseover onmouseup
syn keyword javaScriptHtmlEvents onmousewheel onpause onplay onplaying onprogress onratechange onreadystatechange 
syn keyword javaScriptHtmlEvents onscroll onseeked onseeking onselect onshow onstalled onsubmit onsuspend ontimeupdate 
syn keyword javaScriptHtmlEvents onvolumechange onwaiting

" <body>
syn keyword javaScriptHtmlEvents onafterprint onbeforeprint onbeforeunload onblur onerror onfocus onhashchange onload 
syn keyword javaScriptHtmlEvents onmessage onoffline ononline onpopstate onredo onresize onstorage onundo onunload

" Media Controller
syn keyword javaScriptDomElemAttrs buffered seekable duration currentTime paused
syn keyword javaScriptDomElemAttrs played defaultPlaybackRate playbackRate volume muted
syn keyword javaScriptDomElemAttrs mediaGroup
syn keyword javaScriptDomElemFuncs load play pause 

syn keyword javaScriptHtmlEvents oncanplay oncanplaythrough ondurationchange onemptied 
syn keyword javaScriptHtmlEvents onloadeddata onloadedmetadata onloadstart onpause onplay onplaying onratechange 
syn keyword javaScriptHtmlEvents ontimeupdate onvolumechange onwaiting

" <audio>/<video>
syn keyword javaScriptDomElemAttrs error src currentSrc networkState preload buffered readyState seeking 
syn keyword javaScriptDomElemAttrs currentTime initialTime duration startOffsetTime paused defaultPlaybackRate playbackRate played
syn keyword javaScriptDomElemAttrs seekable ended autoplay loop controls volume muted defaltMuted audioTracks videoTracks textTracks
syn keyword javaScriptDomElemFuncs load addTextTrack

" <video>
" syn keyword javaScriptDomElemAttrs width height
syn keyword javaScriptDomElemAttrs videoWidth videoHeight poster
syntax/html/aria.vim	[[[1
35
" Vim syntax file
" Language:	    WAI-ARIA
" Maintainer:	othree <othree@gmail.com>
" URL:		    http://github.com/othree/html5-syntax.vim
" Last Change:  2010-09-25
" License:      MIT
" Changes:      update to Draft 16 September 2010

" WAI-ARIA States and Properties
" http://www.w3.org/TR/wai-aria/states_and_properties
syn keyword htmlArg contained role

" Global States and Properties
syn match  htmlArg contained "\<aria-\(atomic\|busy\|controls\|describedby\)\>"
syn match  htmlArg contained "\<aria-\(disabled\|dropeffect\|flowto\|grabbed\)\>"
syn match  htmlArg contained "\<aria-\(haspopup\|hidden\|invalid\|label\)\>"
syn match  htmlArg contained "\<aria-\(labelledby\|live\|owns\|relevant\)\>"

" Widget Attributes
syn match  htmlArg contained "\<aria-\(autocomplete\|checked\|disabled\|expanded\)\>"
syn match  htmlArg contained "\<aria-\(haspopup\|hidden\|invalid\|label\)\>"
syn match  htmlArg contained "\<aria-\(level\|multiline\|multiselectable\|orientation\)\>"
syn match  htmlArg contained "\<aria-\(pressed\|readonly\|required\|selected\)\>"
syn match  htmlArg contained "\<aria-\(sort\|valuemax\|valuemin\|valuenow\|valuetext\|\)\>"

" Live Region Attributes
syn match  htmlArg contained "\<aria-\(atomic\|busy\|live\|relevant\|\)\>"

" Drag-and-Drop attributes
syn match  htmlArg contained "\<aria-\(dropeffect\|grabbed\)\>"

" Relationship Attributes
syn match  htmlArg contained "\<aria-\(activedescendant\|controls\|describedby\|flowto\|\)\>"
syn match  htmlArg contained "\<aria-\(labelledby\|owns\|posinset\|setsize\|\)\>"

syntax/html/html5.vim	[[[1
59
" Vim syntax file
" Language:	HTML (version 5)
" Maintainer:	Rodrigo Machado <rcmachado@gmail.com>
" URL:		http://rm.blog.br/vim/syntax/html.vim
" Last Change:  2009 Aug 19
" License:      Public domain
"               (but let me know if you like :) )
"
" Note: This file just adds the new tags from HTML 5
"       and don't replace default html.vim syntax file
"
" Modified:     othree <othree@gmail.com>
" Changes:      update to Draft 13 January 2011
"               add complete new attributes
"               add microdata Attributes
"               add bdi element

" HTML 5 tags
syn keyword htmlTagName contained article aside audio canvas command
syn keyword htmlTagName contained datalist details dialog embed figcaption figure footer
syn keyword htmlTagName contained header hgroup keygen mark meter menu nav output
syn keyword htmlTagName contained progress time ruby rt rp section source summary time track video
syn keyword htmlTagName contained wbr bdi

" HTML 5 arguments
" Core Attributes
syn keyword htmlArg contained accesskey class contenteditable contextmenu dir 
syn keyword htmlArg contained draggable hidden id lang spellcheck style tabindex title
" Event-handler Attributes
syn keyword htmlArg contained onabort onblur oncanplay oncanplaythrough onchange 
syn keyword htmlArg contained onclick oncontextmenu ondblclick ondrag ondragend ondragenter ondragleave ondragover 
syn keyword htmlArg contained ondragstart ondrop ondurationchange onemptied onended onerror onfocus onformchange 
syn keyword htmlArg contained onforminput oninput oninvalid onkeydown onkeypress onkeyup onload onloadeddata 
syn keyword htmlArg contained onloadedmetadata onloadstart onmousedown onmousemove onmouseout onmouseover onmouseup
syn keyword htmlArg contained onmousewheel onpause onplay onplaying onprogress onratechange onreadystatechange 
syn keyword htmlArg contained onscroll onseeked onseeking onselect onshow onstalled onsubmit onsuspend ontimeupdate 
syn keyword htmlArg contained onvolumechange onwaiting
" XML Attributes
syn keyword htmlArg contained xml:lang xml:space xml:base
" new features
" <body>
syn keyword htmlArg contained onafterprint onbeforeprint onbeforeunload onblur onerror onfocus onhashchange onload 
syn keyword htmlArg contained onmessage onoffline ononline onpopstate onredo onresize onstorage onundo onunload
" <video>, <audio>, <source>, <track>
syn keyword htmlArg contained autoplay preload controls loop poster media kind charset srclang track
" <form>, <input>, <button>
syn keyword htmlArg contained form autocomplete autofocus list min max step
syn keyword htmlArg contained formaction autofocus formenctype formmethod formtarget formnovalidate
syn keyword htmlArg contained required placeholder
" <command>, <details>, <time>
syn keyword htmlArg contained label icon open datetime pubdate

" Custom Data Attributes
" http://dev.w3.org/html5/spec/elements.html#embedding-custom-non-visible-data
syn match   htmlArg "\<\(data(\-[a-z]\+)\+\)=" contained

" Microdata
" http://dev.w3.org/html5/md/
syn keyword htmlArg contained itemid itemscope itemtype itemprop itemref
syntax/html/rdfa.vim	[[[1
11
" Vim syntax file
" Language:	    RDFa
" Maintainer:	othree <othree@gmail.com>
" URL:		    http://github.com/othree/html5-syntax.vim
" Last Change:  2010-09-25
" License:      MIT
" Changes:      update to Rec 14 October 2008

" RDFa
" http://www.w3.org/TR/rdfa-syntax/#a_xhtmlrdfa_dtd
syn keyword htmlArg contained about typeof property resource content datatype rel rev 
