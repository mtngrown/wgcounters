# WGCounters - Wargame Counter Generator

## Project Purpose

This Ruby project generates SVG-based counters for conflict simulation wargames. The primary focus is creating area control markers and unit status counters for Vietnam War scenarios, particularly the 11th Armored Cavalry Regiment (Blackhorse) vs PAVN 252 engagements.

## Architecture

### File Organization

```
wgcounters/
├── counter.rb              # Base Counter class with common rendering logic
├── background_fill.rb      # Abstract module for background colors
├── us_background.rb        # US Army unit background colors
├── nv_background.rb        # North Vietnamese unit background colors
├── blackhorse.rb          # 11th ACR Blackhorse counter (executable)
├── blackhorse_counter_sheet.rb  # Sheet generator (executable)
├── original/              # Source SVG assets (unit insignia)
└── generated/             # Output SVG files
```

### Design Patterns

1. **Template Method Pattern**: Base `Counter` class defines structure, subclasses implement specifics
2. **Module Composition**: Background colors via mixins (`UsBackground`, `NvBackground`)
3. **Builder Pattern**: Nokogiri XML Builder for SVG construction

### Workflow

1. **Individual Counter Design**: Create/refine single counter first
2. **Validation**: Run `ruby blackhorse.rb` to generate `generated/blackhorse-counter.svg`
3. **Sheet Generation**: Once validated, run `ruby blackhorse_counter_sheet.rb` for printable sheets

## Counter Specifications

### Dimensions
- Individual counter: 1024 x 1024 pixels (SVG)
- Sheet counter size: 200 x 200 pixels (0.2 scale)
- Sheet layout: 8 rows x 10 columns = 80 counters
- Sheet output: 1000 x 800 pixels at 0.5 global scale

### Color Schemes

**US Army Units (Vietnam War Era)**
- Background: `rgb(106,92,64)` - OG-107 olive drab (authentic Vietnam War uniform color)
- Usage: `include UsBackground`

**North Vietnamese Units**
- Background: `rgb(253,191,191)` - Light red
- Usage: `include NvBackground`

### Historical Accuracy

When selecting colors for military units:
- Research the actual uniform/equipment colors from the period
- OG-107 olive drab was standard US Army 1952-1981 (covers Vietnam War)
- Maintain authenticity for wargaming historical accuracy

## Coding Conventions

### Ruby Style
- Frozen string literals: `# frozen_string_literal: true`
- Method definitions: Use `def method = value` for simple getters
- SVG generation: Use Nokogiri XML Builder pattern
- Path data: Extract as constants at class level (easier to modify)

### SVG Structure
```ruby
def build_counter(xml)
  counter_background(xml)           # Base color rectangle
  xml.g(transform: "...") do
    bounding_box(xml)                # Info box for text
  end
  xml.g(transform: "...") do
    render_insignia(xml)             # Unit insignia/symbols
  end
end
```

### Naming Conventions
- Counter classes: Singular, descriptive (e.g., `Blackhorse`, not `BlackhorseCounter`)
- Sheet generators: `{unit}_counter_sheet.rb`
- Generated files: `generated/{unit}-counter.svg`, `generated/{unit}-counter-sheet.svg`
- Background modules: `{faction}Background` (e.g., `UsBackground`, `NvBackground`)

## Git & Development Workflow

### Commit Messages
- Use detailed, descriptive commit messages that explain the "why" not just the "what"
- Include co-authorship line when working with Claude:
  ```
  Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
  ```
- Prefer reviewing proposed commit messages before committing

### Claude Memory File
- Location: `/Users/daviddoolin/.claude/projects/-Users-daviddoolin-src-wgcounters/memory/MEMORY.md`
- Contains persistent context and patterns learned across sessions
- Automatically loaded in Claude's system prompt for future sessions
- Update when discovering new patterns or user preferences

## Key Implementation Details

### Extracting Path Data from SVG Assets

When integrating unit insignia from `original/` folder:

1. Read the source SVG file
2. Identify all `<path>` elements
3. Extract the `d` attribute (path data) from each
4. Create constants for each path layer
5. Render paths in correct order with original colors

Example:
```ruby
# From 11th_Armored_Cavalry_Regiment_CSIB.svg
PATH_OUTER = 'm 232.56133,198.78711...'  # Black outer shield
PATH_WHITE = 'm 227.25819,196.51158...'  # White inner shield
PATH_RED = 'M 5.8242167,8.0130003...'    # Red diagonal stripe
PATH_DETAILS = 'm 117.36903,280.92198...' # Black details
```

### Scaling and Positioning

- Original SVG assets vary in size (e.g., 235x305 units)
- Calculate scale to fit on 1024x1024 counter with margin
- Use `translate()` and `scale()` in SVG transforms
- Center insignia for visual balance

Example:
```ruby
xml.g(transform: 'translate(277,207) scale(2.0)') do
  render_insignia(xml)
end
```

### Counter Sheet Generation

Simplified approach for identical counters:
```ruby
def row(xml, row_number)
  (1..10).each do |column|
    xml.g(transform: "translate(#{(column - 1) * 200},#{row_number * 200}) scale(0.2)") do
      CounterClass.new.build_counter(xml)
    end
  end
end
```

## TODOs and Known Issues

From code comments:
- [ ] Change counter `initialize` to accept options hash instead of single fill parameter
- [ ] Refactor color definition - current approach of defining colors in separate modules is anti-pattern (consider refactoring)
- [ ] Hardcoded offset calculations need proper formulas based on dimensions
- [ ] Extract magic numbers to constants (offsets, dimensions, coordinates)

## Dependencies

- Ruby 4.0.1
- Nokogiri 1.19.0 (XML/SVG manipulation)
- Bundler 4.0.3+

## Running the Project

```bash
# Install dependencies
bundle install

# Generate individual counter
bundle exec ruby blackhorse.rb

# Generate counter sheet (80 counters)
bundle exec ruby blackhorse_counter_sheet.rb

# Output files in generated/
ls -lh generated/
```

## Future Expansion

Potential counter types based on available assets:
- 1st Cavalry Division counters
- 46th Infantry Regiment counters
- Vietnamese Rangers (ARVN) counters
- PAVN/NVA counters for enemy forces
- Status markers (supply, fatigue, morale, etc.)

Each would follow the same pattern: create individual counter class, extract insignia paths, generate sheet.
