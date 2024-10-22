# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2 meson vala

DESCRIPTION="Code editor designed for elementary OS"
HOMEPAGE="https://github.com/elementary/code"
SRC_URI="https://github.com/elementary/code/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/code-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="plugins policykit"

DEPEND="
	$(vala_depend)
	policykit? ( sys-auth/polkit )
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	plugins? (
		app-text/editorconfig-core-c
		app-text/gtkspell:3[vala]
		net-libs/libsoup:2.4
	)
	dev-libs/glib:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	dev-libs/libgit2-glib
	dev-libs/libpeas[gtk]
	gui-libs/libhandy
	media-libs/fontconfig
	x11-libs/gtk+:3
	x11-libs/gtksourceview:4
	x11-libs/pango
	x11-libs/vte:2.91
"

src_prepare() {
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dplugins=$(usex plugins true false)
		-Dhave_pkexec=$(usex policykit true false)
	)
	meson_src_configure
}
