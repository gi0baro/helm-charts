{{ _genid = uuid.uuid4().hex }}
{{ auto_includes = ['Chart.yaml', 'values.yaml', {'src': '_helpers.tpl', 'dst': 'templates/_helpers.tpl'}] }}
{{ for chart_name, chart_data in charts.items(): }}
rm -rf ../charts/{{ =chart_name }}
mkdir -p ../charts/{{ =chart_name }}/templates/hooks
{{ for tfile in auto_includes: }}
{{ src, dst = (tfile['src'], tfile['dst']) if isinstance(tfile, dict) else (tfile, tfile) }}
noir --delimiters '[[,]]' -v 'name={{ =chart_name }}' -v '_genid={{ =_genid[:12] }}' -c contexts/{{ =chart_name }}.yaml templates/{{ =src }} > ../charts/{{ =chart_name }}/{{ =dst }}
{{ pass }}
{{ for tfile in chart_data.get('includes', []): }}
{{ src, dst = (tfile['src'], tfile['dst']) if isinstance(tfile, dict) else (tfile, tfile) }}
noir --delimiters '[[,]]' -v '_genid={{ =_genid[:12] }}' -c contexts/{{ =chart_name }}.yaml templates/{{ =src }} > ../charts/{{ =chart_name }}/templates/{{ =dst }}
{{ pass }}
{{ pass }}
