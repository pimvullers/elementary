# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala xdg

DESCRIPTION="LightDM Greeter for Pantheon"
HOMEPAGE="https://github.com/elementary/greeter"
SRC_URI="https://github.com/elementary/greeter/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/greeter-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	dev-util/wayland-scanner
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	gui-libs/libhandy:1
	sys-apps/accountsservice
	gnome-base/gnome-desktop:3
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-misc/lightdm[introspection,vala]
	x11-wm/mutter
"

src_prepare() {
	eapply_user
	eapply "${FILESDIR}/${P}_dropold.patch"
	eapply "${FILESDIR}/${P}_mutter48.patch"
	vala_setup
}
