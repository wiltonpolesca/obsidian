For a financial application like "Gallery," where user trust and clear navigation are paramount, I recommend a **Responsive Hybrid Sidebar/Drawer pattern**. This approach ensures that your complex, multi-level financial data remains organized on large screens while maintaining a clean, accessible interface on smaller devices.

### Recommended Design Pattern: The Responsive Hybrid

This pattern switches behavior based on the viewport size, ensuring the user is never overwhelmed by menu items.

|**Viewport Size**|**Navigation Style**|**Behavior**|
|---|---|---|
|**Desktop/Tablet (Landscape)**|**Permanent Sidebar**|Stays docked to the left. Sub-menus are revealed via accordion expansion.|
|**Mobile/Small Tablet (Portrait)**|**Hamburger Drawer**|Hidden behind a top-left hamburger menu. Slides out to full screen or a large modal.|

### UI/UX Design Mockups

#### 1. Desktop: The Persistent Sidebar

- **Structure:** A fixed-width sidebar (e.g., 260px) on the left.
    
- **Interaction:** Use an **accordion style** for sub-menus. When a top-level item like "Reports" is clicked, it expands downward, pushing the subsequent menu items down rather than covering them.
    
- **Visuals:** Use the Sapphire Blue (#0056D6) for the active selection indicator (a small vertical line on the left edge of the active item) to ensure the user knows where they are in your "Gallery" suite.
    

#### 2. Mobile: The Bottom-Sheet or Drawer

- **Structure:** Use a standard "Hamburger" menu icon in the top header.
    
- **Interaction:** Upon tapping, the navigation should slide out as a **Full-Screen Modal**. This provides ample space for your sub-menus, which can be easily tapped without accidental clicks on adjacent items.
    
- **Efficiency:** For a finance app, consider adding a **"Quick Action" Floating Action Button (FAB)** at the bottom-right of the screen on mobile, allowing users to quickly add a transaction or check a balance without navigating the main menu.
    

### Implementation Tips for "Gallery"

- **Sub-menu Hierarchy:** Since finance apps can grow complex, limit your sub-menus to one level deep. If you need a third level, use a separate "Settings" or "Details" page for that specific module.
    
- **Visual Consistency:** Even when the navigation style changes (from sidebar to drawer), keep the icon set consistent. The same "Reports" icon used in the desktop sidebar must be used in the mobile drawer to maintain brand identity.
    
- **Active State Feedback:** In both views, ensure the active page is highlighted using your **Action Teal (#14B8A6)** to provide immediate visual confirmation of the user's location.

![[fin-app-example-2-levels.png]]

---

## 3 levels

Managing three levels of navigation requires a careful balance between accessibility and density to ensure users don't feel lost in the hierarchy. When using three levels, the goal is to prevent "menu fatigue" while maintaining a clear sense of location within the application.

### Recommended 3-Level Navigation Strategy

For "Gallery," I recommend a **Nested Accordion with Visual Cues**. This keeps the interface clean while clearly defining depth.

- **Level 1 (Top Level):** Icons and primary labels (e.g., Reports).
    
- **Level 2 (Category):** Indented text lists under the parent.
    
- **Level 3 (Sub-category/Action):** Further indented or distinguished by a lighter font weight, smaller size, or a bullet point.
    

#### Design Adjustments for 3 Levels

1. **Visual Indentation:** Use a 16px to 24px indentation step for each level. This creates a visual "staircase" effect that naturally guides the eye to the deeper content.
    
2. **State Indication:**
    
    - **Expand/Collapse Arrows:** Use chevron icons ($>$) that rotate $90^\circ$ when expanded.
        
    - **Highlighting:** Keep the "Primary Sapphire" indicator for the active path, but use a subtle gray or "Teal" tint on the background of the entire branch so the user knows they are still within that specific category.
        
3. **The "Active" Anchor:** When a Level 3 item is selected, ensure the parent (Level 2) and grandparent (Level 1) remain visually "active" or "highlighted" to preserve the context of where the user is within the structure.
    

### Implementation Mockup (Conceptual Logic)

To visualize this, your side menu structure would function like this:

> - **Reports** (Level 1)
>     
>     - **Annual** (Level 2)
>         
>         - _Summary_ (Level 3)
>             
>         - _Detailed_ (Level 3)
>             
>     - **Quarterly** (Level 2)
>         
>         - _Q1 Analysis_ (Level 3)
>             

### UX Consideration for Mobile

On mobile, three levels can quickly become cluttered. For your mobile implementation, I suggest:

- **Drill-down Navigation:** Instead of expanding everything in one list, tapping a Level 1 item could slide the current view out and replace it with the list of Level 2 items. This is a common pattern in mobile finance apps to keep the view focused and readable.
    
- **Breadcrumbs:** If a user navigates to Level 3, provide a small "Back" button or a breadcrumb trail at the top of the content area (e.g., `Reports > Annual > Summary`) so they can navigate up without hitting the main menu again.

---

Choosing a **drill-down navigation** pattern is an excellent decision for a finance application. It feels more "premium" and allows users to focus entirely on the specific financial data they are currently examining, which reduces cognitive load and keeps the mobile interface clean.

### The Drill-Down Pattern: How it Works

Instead of expanding menus within the same view, each tap on a parent item "pushes" a new menu layer onto the screen.

1. **Level 1 (Main Menu):** Displays high-level categories (e.g., Dashboard, Reports, Settings).
    
2. **Level 2 (Category Detail):** When a user taps "Reports," the screen slides to show only sub-options (e.g., Annual, Quarterly, Monthly).
    
3. **Level 3 (Action Detail):** Tapping "Annual" slides again to show the specific views (e.g., P&L, Cash Flow, Tax).
    

### Key Implementation UX Elements

To make this feel cohesive and intuitive in your app:

- **Breadcrumb Header:** When the user is at Level 2 or 3, the top of the menu should show a back button (e.g., `< Back`) or the name of the parent category. This ensures the user never feels lost in the hierarchy.
    
- **Smooth Transition Animations:** Use a "slide-in" animation from the right for deeper levels and a "slide-out" animation to the right when returning to a higher level. This provides a tactile sense of movement through the "Gallery" structure.
    
- **Visual Continuity:** Even though the content changes, the header of your mobile drawer should maintain consistent branding (the "Gallery" wordmark) so the user always knows they are within your application.
    
- **Depth Feedback:** For Level 3 items, you can use a slightly different iconography or a different shade of your "Action Teal" to indicate that this is a final, actionable item rather than another category.
    

### Why this fits your "Gallery" vision

The "Gallery" concept is essentially about **curation**. A drill-down approach mimics the experience of walking through a physical gallery: you enter a room (Level 1), look at a collection (Level 2), and then focus on a specific piece of art (Level 3). It turns your financial management into an intentional, focused process rather than a crowded list of tasks.

Since you are using Angular, you can achieve this quite cleanly using a state management service to track the `currentView` and a simple `*ngIf` or `router-outlet` structure to swap between the menu levels, keeping the animations smooth and performant.

![[fin-app-example-3-levels.png]]
```html
<mat-sidenav-container class="sidenav-container">
  <mat-sidenav #drawer [mode]="isMobile ? 'over' : 'side'" [opened]="!isMobile">
    <mat-nav-list>
      <a mat-list-item routerLink="/dashboard">Dashboard</a>
      <a mat-list-item routerLink="/accounts">Accounts</a>

      <mat-expansion-panel class="mat-elevation-z0">
        <mat-expansion-panel-header>
          <mat-panel-title>Reports</mat-panel-title>
        </mat-expansion-panel-header>
        
        <mat-nav-list>
          <a mat-list-item routerLink="/reports/annual">Annual</a>
          <a mat-list-item routerLink="/reports/quarterly">Quarterly</a>
        </mat-nav-list>
      </mat-expansion-panel>

      <a mat-list-item routerLink="/goals">Goals</a>
      <a mat-list-item routerLink="/settings">Settings</a>
    </mat-nav-list>
  </mat-sidenav>

  <mat-sidenav-content>
    <button mat-icon-button (click)="drawer.toggle()" *ngIf="isMobile">
      <mat-icon>menu</mat-icon>
    </button>
    <router-outlet></router-outlet>
  </mat-sidenav-content>
</mat-sidenav-container>
```
