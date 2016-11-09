# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="The official elementary GTK theme"
HOMEPAGE="https://launchpad.net/egtk"
SRC_URI="https://launchpad.net/egtk/5.x/${PV}/+download/elementary.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk +gtk3 +icons +wallpapers"

DEPEND="
	x11-themes/vanilla-dmz-aa-xcursors"
RDEPEND="${DEPEND}
	media-fonts/droid
	gtk? (
		x11-libs/gtk+:2
		x11-themes/gtk-engines-murrine
	)
	gtk3? (
		x11-libs/gtk+:3
		x11-themes/gtk-engines-unico
	)
	icons? (
		x11-themes/elementary-icon-theme
		x11-themes/hicolor-icon-theme
	)
	wallpapers? (
		x11-themes/elementary-wallpapers
	)"

RESTRICT="binchecks mirror strip"

S="${WORKDIR}/elementary"
DOCS=( AUTHORS CONTRIBUTORS COPYING )

src_prepare() {
	eapply_user

	# Correct cursor theme name
	sed -i 's/DMZ-Black/Vanilla-DMZ-AA/' index.theme

	sed -i \
		-e 's/icon-shadow/-gtk-icon-shadow/' \
		-e 's/-gtk-image-effect/-gtk-icon-effect/' \
		-e 's/:prelight/:hover/' \
		-e 's/:insensitive/:disabled/' \
		-e '/-GtkWidget-separator-height:/d' \
		-e '/-GtkWidget-separator-width:/d' \
		-e '/-GtkWidget-wide-separators:/d' \
		-e '/-GtkWidget-focus-line-width:/d' \
		-e '/-GtkWidget-focus-padding:/d' \
		-e '/-GtkWidget-link-color:/d' \
		-e '/-GtkWidget-visited-link-color:/d' \
		gtk-3.0/*.css
}

src_install() {
	insinto /usr/share/themes/elementary
	doins -r index.theme gtk-2.0 gtk-3.0

	base_src_install_docs
}
