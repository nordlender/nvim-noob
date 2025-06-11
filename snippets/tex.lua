
local function ismath()
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
end

local function no_ismath()
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 0
end


-- set a higher priority (defaults to 0 for most snippets)
-- yes I know this is stupid af haha
local snippets = {
  snippets = {
    { trig = 'LTJournalArticleTemplate', name = 'LTJournalArticle Template', body = '\\documentclass[\na4paper, % Paper size, use either a4paper or letterpaper \n10pt, % Default font size, can also use 11pt or 12pt, although this is not recommended \nunnumberedsections, % Comment to enable section numbering \ntwoside, % Two side traditional mode where headers and footers change between odd and even pages, comment this option to make them fixed\n]{LTJournalArticle}\n\n\\usepackage{fancyhdr}\n\\usepackage{etoolbox}\n\\usepackage{multicol}\n\\usepackage{lmodern}\n\\usepackage{csquotes}\n\n% Bibliography\n\\usepackage[\nbackend=biber,\nstyle=apa\n]{biblatex}\n\\addbibresource{$1}\n% ---\n\n% Page header/footer\n\\pagestyle{fancy}\n\\fancyhf{}\n\\rhead{$2}\n\\lhead{\\thepage}\n% ---\n\n% Title page\n\\title{$3}\n\\author{$4}\n\\date{$5}\n\n\\begin{document}\n\\maketitle\n % ---\n% Start\n\n\n\n% ---\n End\\printbibliography\n\\end{document}'},
  },
  autosnippets = {
    { trig = ' ctp', name = 'parencite', condition = no_ismath, priority = 10, body = '\\parencite{$1}$0' },
    { trig = ' ctt', name = 'parencite', condition = no_ismath, priority = 10, body = '\\textcite{$1}$0' },
    { trig = 'bf', name = 'mathbf', condition = ismath, priority = 10, body = '\\mathbf{$1}$0' },
    { trig = 'ptl', name = 'partial', condition = ismath, priority = 10, body = '\\partial ' },
  }
}

return snippets

