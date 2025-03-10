function seekSkillIcons() {
  document.querySelectorAll("#skills a").forEach(async (link) => {
    const url = new URL(link.getAttribute("href"));
    ["favicon.ico", "favicon.png", "favicon-32.png"].forEach((variant) => {
      const icon = document.createElement("img");
      url.pathname = `/${variant}`;
      icon.setAttribute("src", url.toString());
      icon.classList.add("hidden");
      icon.addEventListener("load", () => {
        if (link.querySelector("img:not(.hidden)")) return;
        icon.classList.remove("hidden");
      });
      link.prepend(icon);
    });
  });
}

document.addEventListener("DOMContentLoaded", () => {
  // seekSkillIcons();
});
