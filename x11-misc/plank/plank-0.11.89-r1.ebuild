# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8
inherit autotools gnome2 vala

DESCRIPTION="Elegant, simple, clean dock"
HOMEPAGE="https://github.com/ricotz/plank"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="https://github.com/ricotz/plank/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64"
fi

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"
IUSE="dbus debug nls"

VALA_USE_DEPEND="vapigen"

RDEPEND="app-accessibility/at-spi2-core
	dev-libs/glib:2
	dev-libs/libdbusmenu[gtk,gtk3]
	dev-libs/libgee
	x11-libs/bamf[introspection]
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libwnck
	gnome-base/gnome-menus:3
	x11-libs/pango"

DEPEND="${RDEPEND}
	$(vala_depend)"

src_prepare() {
	eapply "${FILESDIR}/21d15e72d1afd11a78eb152c577dfd7765935c01.patch"
	eapply "${FILESDIR}/5967798a47ba8835ae100c01a8d647d2f9a2412f.patch"
	eapply "${FILESDIR}/6ca78b3d3890786d11b5fdb934260f9082e4561a.patch"
	eapply "${FILESDIR}/7aa7904252ba28eb0fa5232bbf094eafe1d9b966.patch"
	eapply "${FILESDIR}/d83adef3a459042d2932ce26252af221620342fb.patch"
	eapply_user
	eautoreconf
	vala_setup
}

src_configure() {
	econf \
		$(use_enable dbus dbusmenu) \
		$(use_enable debug) \
		$(use_enable nls)
}
